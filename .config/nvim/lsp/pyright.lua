-- Function to find uv virtual environment
local function find_uv_venv()
  local cwd = vim.fn.getcwd()
  local venv_path = cwd .. "/.venv"

  -- Check if .venv exists (uv's default)
  if vim.fn.isdirectory(venv_path) == 1 then
    local python_path = venv_path .. "/bin/python"
    if vim.fn.executable(python_path) == 1 then
      return python_path
    end

    -- Windows support
    python_path = venv_path .. "/Scripts/python.exe"
    if vim.fn.executable(python_path) == 1 then
      return python_path
    end
  end

  -- Fallback to system python
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

local function set_python_path(path)
  local clients = vim.lsp.get_clients {
    bufnr = vim.api.nvim_get_current_buf(),
    name = 'pyright',
  }
  for _, client in ipairs(clients) do
    if client.settings then
      client.settings.python = vim.tbl_deep_extend('force', client.settings.python, { pythonPath = path })
    else
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, { python = { pythonPath = path } })
    end
    client.notify('workspace/didChangeConfiguration', { settings = nil })
  end
end

return {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
    '.git',
  },
  settings = {
    python = {
      pythonPath = find_uv_venv(), -- Auto-detect uv venv
      analysis = {
        -- autoSearchPaths = true,
        -- useLibraryCodeForTypes = true,
        -- diagnosticMode = 'openFilesOnly',
        ignore = { '*' },
      },
    },
    pyright = {
      disableOrganizeImports = true,
    },
  },
  on_attach = function(client, bufnr)
    -- Auto-update python path when entering buffer
    local python_path = find_uv_venv()
    set_python_path(python_path)
    -- Disable pyright's formatting in favor of ruff
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightOrganizeImports', function()
      client:exec_cmd({
        command = 'pyright.organizeimports',
        arguments = { vim.uri_from_bufnr(bufnr) },
      })
    end, {
      desc = 'Organize Imports',
    })

    vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightSetPythonPath', function(opts)
      set_python_path(opts.args)
    end, {
      desc = 'Reconfigure pyright with the provided python path',
      nargs = 1,
      complete = 'file',
    })

    -- Add command to show current python path
    vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightShowPythonPath', function()
      local current_path = find_uv_venv()
      print("Current Python path: " .. current_path)
    end, {
      desc = 'Show current python path',
    })

    -- Add command to refresh python path
    vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightRefreshPythonPath', function()
      local new_path = find_uv_venv()
      set_python_path(new_path)
      print("Updated Python path to: " .. new_path)
    end, {
      desc = 'Refresh python path from uv venv',
    })
  end,
}
