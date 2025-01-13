require("config.lazy")

vim.api.nvim_create_autocmd("TermOpen", {pattern = "*", command = "lua vim.keymap.set('t', '<Esc>', [[<c-\\><c-n>]], {buffer = true})", once =true})
vim.api.nvim_create_autocmd("TextYankPost", {pattern = "*", command = "lua vim.highlight.on_yank()", once = true})
