vim.api.nvim_create_autocmd("TextYankPost", {pattern = "*", command = "lua vim.highlight.on_yank()", once = true})
vim.api.nvim_create_autocmd("TermOpen", {pattern = "*", command = "lua vim.keymap.set('t', '<Esc>', [[<c-\\><c-n>]], {buffer = true})", once =true})
vim.api.nvim_create_autocmd("Filetype", {pattern = "startify", command = "IBLDisable", once = true})
