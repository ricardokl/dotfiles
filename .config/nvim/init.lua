require("config.autocmds")
require('config.keymaps')
require('config.opts')
require("config.lazy")
require("aichat")
vim.cmd.colorscheme("onedark")

function reload_config()
  package.loaded["aichat"] = false
  require("aichat")
  vim.notify("Aichat reloaded", vim.log.levels.INFO)
end

vim.keymap.set(
  'n',
  '<leader>mr',
  '<cmd>lua reload_config()<CR>',
  {
    noremap = true,
    silent = true,
    desc = "Reload aichat module"
  })
