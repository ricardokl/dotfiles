-- ruff.lua (using ruff server)
return {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'ruff.toml',
    '.ruff.toml',
    '.git',
  },
  settings = {
    -- Ruff server settings
    interpreter = vim.fn.getcwd() .. "/.venv/bin/python", -- Use your uv venv
    logLevel = "info",                                    -- default, or set to "debug" for more verbose logging
  },
  on_attach = function(client, bufnr)
    -- Disable capabilities that conflict with pyright
    client.server_capabilities.hoverProvider = false
    client.server_capabilities.definitionProvider = false
    client.server_capabilities.referencesProvider = false
    client.server_capabilities.renameProvider = false

    -- Keep only formatting and diagnostics
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true
  end,
}
