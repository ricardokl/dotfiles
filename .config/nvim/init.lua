vim.g.augment_disable_tab_mapping = true

require("config.autocmds")
require('config.keymaps')
require('config.opts')
require("config.lazy")
-- require("config.lsp")
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


-- vim.lsp.config('*', {
--   capabilities = require('bink.cmp').get_lsp_capabilities()
-- })
--
-- vim.lsp.config('luals', {
--   settings = {
--     Lua = {}
--   },
--   on_init = function(client)
--     if client.workspace_folders then
--       local path = client.workspace_folders[1].name
--       if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
--         return
--       end
--     end
--     client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
--       runtime = {
--         version = 'LuaJIT'
--       },
--       workspace = {
--         checkThirdParty = false,
--         library = {
--           vim.env.VIMRUNTIME
--         }
--       }
--     })
--   end,
-- })
--
-- vim.lsp.enable('luals')
-- vim.lsp.enable('pyright')
-- vim.lsp.enable('vimls')
-- vim.lsp.enable('rust_analyzer')
