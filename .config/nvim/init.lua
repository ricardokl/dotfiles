require("config.autocmds")
require('config.keymaps')
require('config.opts')
require("config.lazy")
require("aichat_nvim")
require("augment_apply")
vim.cmd.colorscheme("onedark")
-- vim.o.laststatus = 0
vim.g.augment_workspace_folders = { '/home/ricardo/projects/onedark_nvim_rs/', '/home/ricardo/projects/aider/',
  '/home/ricardo/projects/straico-client/', '/home/ricardo/projects/straico-proxy/',
  '/home/ricardo/projects/aichat_nvim/' }
