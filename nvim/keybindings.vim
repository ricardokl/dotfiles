" Keybindings

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
nnoremap <leader>ff :Files ~<cr>
nnoremap <leader>f. :Files ./<cr>
"}}}

"{{{ Movendo com [x
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
"}}}

"{{{ Neoterm
map <leader><leader> <Plug>(neoterm-repl-send)ap
map <leader>p <Plug>(neoterm-repl-send)
"}}}

" ESC no terminal como no resto
tnoremap <esc> <c-\><c-n>

nnoremap <silent> <c-t> :tabnew<CR>

nnoremap <BS> X

nnoremap <leader>h :call Html()<cr>
nnoremap <leader>w :w <cr>:so % <cr>
xmap <Leader>z <Plug>(Limelight)<cr>
nnoremap <leader>z :Limelight0.8<cr>
nnoremap <leader>x :Limelight!<cr>
map <c-p> <Plug>MarkdownPreviewToggle
nmap <leader>t :TagbarToggle<CR>

"{{{ Remove pageup e pagedown de todos os modos
map <PageUp> <Nop>
map <PageDown> <Nop>
"}}}
