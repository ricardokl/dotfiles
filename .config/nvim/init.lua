vim.g.augment_disable_tab_mapping = true

require("config.autocmds")
require('config.keymaps')
require('config.opts')
require("config.lazy")
vim.cmd.colorscheme("onedark")

local has_aichat = pcall(require, "aichat_nvim")
if not has_aichat then
  vim.notify("aichat_nvim lib not found", vim.log.levels.WARN)
end

local has_augment = pcall(require, "libaugment_extras")
if not has_augment then
  vim.notify("libaugment_extras lib not found", vim.log.levels.WARN)
end

vim.g.augment_workspace_folders = {
  -- '~/projects/onedark_nvim_rs/',
  -- '~/projects/aider/',
  -- '~/projects/straico-client/',
  -- '~/projects/straico-proxy/',
  -- '~/projects/aichat_nvim/',
  '~/projects/augment_extras/',
}
