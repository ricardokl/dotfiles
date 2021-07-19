" Keybindings

let g:mapleader=" "

nnoremap <silent> <leader>m :Neomake<cr>

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
nnoremap <c-K> <c-w>K
nnoremap <c-J> <c-w>J
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
nnoremap <leader><leader> :Files ~<cr>
nmap <silent> <leader>ft :BTags<cr>
nmap <silent> <leader>ls :Buffers<cr>
nmap <silent> <leader>f. :GFiles .<cr>
"}}}

"{{{ Movendo com [x
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
"}}}

"{{{ Floatterm
nnoremap <leader>tr :FloatermNew ranger<cr>
nnoremap <leader>tt :FloatermToggle!<cr>
nnoremap <leader>tk :FloatermKill<cr>
nnoremap <leader>tc :FloatermNew! cht.sh --shell<cr>
"}}}

"{{{ Coc
nnoremap <leader>cc :CocFzfList<cr>
nnoremap <leader>cq :CocFzfList quickfix<cr>
nnoremap <leader>co :CocFzfList outline<cr>
"}}}

" ESC no terminal como no resto
if has("nvim")
  au! TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au! FileType fzf tunmap <buffer> <Esc>
endif

nnoremap <silent> <c-t> :tabnew<CR>

nnoremap <BS> X

imap <C-j> <Plug>(coc-snippets-expand-jump)

"{{{ Remove pageup e pagedown de todos os modos
map <PageUp> <Nop>
map <PageDown> <Nop>
"}}}

"{{{ Abreviações
iabbrev => ⇒
iabbrev <= ⇐
iabbrev -> →
iabbrev <- ←
iabbrev >> »
iabbrev << «
iabbrev *x ×
iabbrev *. ⋅
iabbrev -: ÷
iabbrev :- ÷
iabbrev D* Δ
iabbrev *D Δ
iabbrev <-> ↔
iabbrev <=> ⇔
iabbrev +- ±
iabbrev -+ ∓
" <ctrl-k>OK ⇒ ✓
" <ctrl-k>XX ⇒ ✗
" <ctrl-k>2S ⇒ ²
" <ctrl-k>2s ⇒ ₂
"}}}
