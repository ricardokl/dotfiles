vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "rust", "json", "python", "sh", "bash" },
  callback = function()
    vim.opt_local.foldmethod = "indent"
    vim.opt_local.foldenable = true
    vim.opt_local.foldlevel = 99
  end
})

vim.api.nvim_create_autocmd("TermOpen",
  { pattern = "*", command = "lua vim.keymap.set('t', '<Esc>', [[<c-\\><c-n>]], {buffer = true})", once = true })

vim.api.nvim_create_autocmd("TextYankPost", { pattern = "*", command = "lua vim.highlight.on_yank()", once = true })
