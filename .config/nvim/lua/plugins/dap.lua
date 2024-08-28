local dap = require("dap")
dap.configurations.lua = { 
  { 
    type = 'nlua', 
    request = 'attach',
    name = "Attach to running Neovim instance",
  }
}

dap.adapters.nlua = function(callback, config)
  callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
end

dap.adapters.python = function(cb, config)
  if config.request == 'attach' then
    ---@diagnostic disable-next-line: undefined-field
    local port = (config.connect or config).port
    ---@diagnostic disable-next-line: undefined-field
    local host = (config.connect or config).host or '127.0.0.1'
    cb({
      type = 'server',
      port = assert(port, '`connect.port` is required for a python `attach` configuration'),
      host = host,
      options = {
        source_filetype = 'python',
      },
    })
  else
    cb({
      type = 'executable',
      command = '/home/ricardo/.local/share/mise/installs/python/3.12/bin/python',
      args = { '-m', 'debugpy.adapter' },
      options = {
        source_filetype = 'python',
      },
    })
  end
end

dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = "Launch file";
    program = "${file}";
    pythonPath = '/home/ricardo/.local/share/mise/installs/python/3.12/bin/python' 
    -- pythonPath = function()
    --   -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
    --   -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
    --   -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
    --   local cwd = vim.fn.getcwd()
    --   if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
    --     return cwd .. '/venv/bin/python'
    --   elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
    --     return cwd .. '/.venv/bin/python'
    --   else
    --     return '/usr/bin/python'
    --   end
    -- end;
  },
}

require("nvim-dap-virtual-text").setup {
    highlight_changed_variables = true,
    highlight_new_as_changed = true,
    commented = true,
}
