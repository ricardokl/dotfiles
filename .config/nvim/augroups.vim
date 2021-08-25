au! TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
au TextYankPost * silent! lua vim.highlight.on_yank()
au filetype vimwiki silent! iunmap <buffer> <Tab>
au filetype * silent! :COQnow -s
