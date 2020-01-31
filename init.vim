set nocompatible

"{{{ Plugins
call plug#begin('~/.config/nvim/plugged/')

Plug 'SirVer/ultisnips'
Plug 'tomasr/molokai'
Plug 'bling/vim-airline'
Plug 'lervag/vimtex'
Plug 'KeitaNakamura/tex-conceal.vim'
Plug 'jez/vim-superman'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'iamcco/markdown-preview.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive' 
Plug 'airblade/vim-gitgutter'

call plug#end()
"}}}

"{{{ Settings
syntax on
filetype plugin indent on
" set number
" set relativenumber
set scrolloff=10
set ruler
set encoding=utf-8
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr>" clear search
set background=dark
set visualbell
set foldmethod=marker
set cmdheight=2
set shortmess+=c
set signcolumn=yes
set updatetime=100
colorscheme slate

"}}}

"{{{ Netrw like NERDtree
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
"}}}

"{{{ Vimtex settings
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:vimtex_compiler_latexmk = { 'options' : [ '-pdf', '-pdflatex="xelatex --shell-escape %O %S"', '-verbose', '-file-line-error', '-synctex=1', '-interaction=nonstopmode',  ] }
autocmd FileType tex setlocal ts=2 sw=2 sts=0 expandtab spell
let g:vimtex_complete_enabled = 1
let g:vimtex_complete_close_braces = 1
let g:vimtex_complete_ignore_cas = 1
let g:vimtex_complete_smart_case = 1
let g:vimtex_compiler_progname='nvr'
"}}}

"{{{ Ultisnips settings
let g:UltisnipsExandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
"}}}
 
"{{{ tex-conceal settings
set conceallevel=1
let g:tex_conceal='abdmg'
"}}}
  
"{{{ Keybindings
inoremap ., <esc>
inoremap ,. <esc>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h
nnoremap <c-Down> <c-w>j
nnoremap <c-Up> <c-w>k
nnoremap <C-Left> <c-w>h
nnoremap <C-Right> <c-w>l
tnoremap <esc> <c-\><c-n>
nnoremap <cr> o<esc>
"}}}

let g:python3_host_prog='/home/ricardo/anaconda3/bin/python'
