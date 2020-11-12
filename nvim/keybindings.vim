" Keybindings

let g:mapleader=" "

"{{{ Splits
"{{{ Movendo nos splits
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-Down> <c-w>j
nnoremap <c-Up> <c-w>k
nnoremap <C-Left> <c-w>h
nnoremap <C-Right> <c-w>l
"}}}

"{{{ Movendo *os* splits
nnoremap <c-L> <c-w>L
nnoremap <c-H> <c-w>H
"}}}

"{{{ Mudando o tamanho de splts
nnoremap <silent> <M-j>    :resize -2<CR>
nnoremap <silent> <M-k>    :resize +2<CR>
nnoremap <silent> <M-h>    :vertical resize -2<CR>
nnoremap <silent> <M-l>    :vertical resize +2<CR>
nnoremap <silent> <M-Down>    :resize -2<CR>
nnoremap <silent> <M-Up>    :resize +2<CR>
nnoremap <silent> <M-Left>    :vertical resize -2<CR>
nnoremap <silent> <M-Right>    :vertical resize +2<CR>
"}}}
"}}}

"{{{ FZF
nnoremap <leader>fh :Files ~<cr>
nmap <silent> <leader>t :BTags<cr>
nmap <silent> <leader>ls :Buffers<cr>
nmap <silent> <leader>bl :BLines<cr>
"}}}

"{{{ Movendo com [x
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
"}}}

"{{{ Neoterm
map <leader><leader> <Plug>(neoterm-repl-send)ap
map <leader>s <Plug>(neoterm-repl-send)
"}}}

"{{{ Coc
nnoremap <leader>cc :CocFzfList<cr>
nnoremap <leader>cq :CocFzfList quickfix<cr>
nnoremap <leader>o :CocFzfList outline<cr>
"}}}

" ESC no terminal como no resto
if has("nvim")
  au! TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au! FileType fzf tunmap <buffer> <Esc>
endif

nnoremap <silent> <c-t> :tabnew<CR>

nnoremap <BS> X

imap <C-j> <Plug>(coc-snippets-expand-jump)

nnoremap <leader>h :call Html()<cr>
nnoremap <leader>w :w <cr>:so %<cr>
nmap <silent> <leader>p <Plug>MarkdownPreviewToggle

"{{{ Remove pageup e pagedown de todos os modos
map <PageUp> <Nop>
map <PageDown> <Nop>
"}}}
