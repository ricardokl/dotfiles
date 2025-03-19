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

-- Check for file changes when these events occur
vim.api.nvim_create_autocmd({
  "BufEnter",
  "CursorHold",
  "CursorHoldI",
  "FocusGained",
  "WinEnter",  -- Added to detect when switching windows
  "VimResume", -- Added to detect when Neovim regains focus
}, {
  callback = function()
    if vim.fn.mode() ~= 'c' then
      local bufnr = vim.api.nvim_get_current_buf()
      -- Only check files that exist on disk and are loaded
      if vim.fn.filereadable(vim.fn.expand('%')) == 1 and vim.bo[bufnr].buftype == '' then
        vim.cmd('checktime ' .. bufnr)
      end
    end
    return true
  end,
  pattern = "*",
  desc = "Check for external file changes"
})

-- Notification when a file has changed
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.WARN)
  end,
  pattern = "*",
  desc = "Notify when file is changed externally"
})
