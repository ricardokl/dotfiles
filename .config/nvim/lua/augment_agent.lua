vim.api.nvim_create_autocmd("User", {
  pattern = "ChatResponse",
  callback = function()
    vim.notify("Augment response recieved", vim.log.levels.INFO, {
      title = "Augment Chat",
      timeout = 5000 -- 5 seconds
    })
  end,
})
