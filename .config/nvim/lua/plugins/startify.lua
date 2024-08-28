vim.g.startify_session_dir = '~/.config/nvim/session'
vim.g.startify_lists = {
  { type = 'bookmarks', header = {'Bookmarks'}},
  { type = 'files', header = {'Recentes'}},
  { type = 'sessions', header = {'Sessions'}}
}
vim.g.webdevicons_enable_startify = 1
vim.g.startify_bookmarks = {
  { v = '~/dotfiles/.config/nvim/' },
  { z = '~/dotfiles/.zshrc' },
}
vim.g.startify_files_number = 5
vim.g.startify_fortune_use_unicode = 1
vim.g.startify_padding_left = 20
