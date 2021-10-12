au! TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
au! TextYankPost * silent! lua vim.highlight.on_yank()
au! filetype vimwiki silent! iunmap <buffer> <Tab>
au! filetype * silent! :COQnow -s

augroup python
  autocmd!
  autocmd filetype *.py nnoremap <leader><leader> :FloatermNew --disposable python %<cr>
augroup END

augroup rust
  autocmd!
  autocmd filetype *.rs nnoremap <leader><leader> :FloatermNew --disposable cargo run<cr>
augroup END
