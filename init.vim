set nocompatible

"{{{ Plugins
call plug#begin('~/.config/nvim/plugged/')
"
" Generic
Plug 'bling/vim-airline'
Plug 'flazz/vim-colorschemes'
Plug 'dracula/vim'
Plug 'haya14busa/is.vim'
Plug 'kyoz/purify', { 'rtp': 'vim' }
Plug 'Yggdroot/indentLine'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
" Utilities
Plug 'dhruvasagar/vim-table-mode'
Plug 'jez/vim-superman'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-commentary'
Plug 'ludovicchabant/vim-gutentags'
Plug 'jiangmiao/auto-pairs'
Plug 'kassio/neoterm'
Plug 'tpope/vim-surround'
" Latex
Plug 'lervag/vimtex'
Plug 'KeitaNakamura/tex-conceal.vim'
" Markdown
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'iamcco/markdown-preview.nvim'
" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Python
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-vim'
Plug 'deoplete-plugins/deoplete-jedi'
" Plug 'zchee/deoplete-jedi'
Plug 'skammer/vim-css-color'
Plug 'liuchengxu/vista.vim'
call plug#end()
"}}}

"{{{ Settings
syntax on
filetype plugin indent on
set number
" set relativenumber
set mouse=a
set clipboard=unnamedplus
"set tabstop=2 softtabstop=2 shiftwidth=2 "expandtab
set scrolloff=10
set encoding=utf-8
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
set background=dark
set visualbell
set foldmethod=marker
set shortmess+=c
set signcolumn=auto
set updatetime=100
set noemoji
set spell
set spelllang=en_us,pt_br
set list listchars=trail:-
set virtualedit=block
set completeopt=menu
" colorscheme solarized8_dark_low
colorscheme dracula
" colorscheme PaperColor
" colorscheme badwolf
" colorscheme purify
let g:airline_theme='purify'
"
"}}}

autocmd FileType tex setlocal ts=2 sw=2 sts=0 noexpandtab spell
let g:deoplete#enable_at_startup = 1
inoremap <C-space> :call deoplete#complete()
let g:vista#renderer#enable_icon = 1
let g:vista_fzf_preview = ['right:50%']
let g:vista_default_executive = 'ctags'
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista#renderer#icons = {
\   "function": "ﬀ",
\   "variable": "✗",
\  }

"{{{ Netrw like NERDtree
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
"}}}

""{{{ Vimtex settings
"let g:tex_flavor='latex'
"let g:vimtex_view_method='zathura'
"let g:vimtex_quickfix_mode=0
"" let g:vimtex_quickfix_enabled
"let g:vimtex_compiler_latexmk = { 'options' : [ '-pdf', '-pdflatex="xelatex --shell-escape %O %S"', '-verbose', '-file-line-error', '-synctex=1', '-interaction=nonstopmode',  ] }
"let g:vimtex_complete_enabled = 1
"let g:vimtex_complete_close_braces = 1
"let g:vimtex_complete_ignore_case = 1
"let g:vimtex_complete_smart_case = 1
"" let g:vimtex_compiler_progname='nvr'
""}}}

"{{{ Ultisnips settings
let g:UltisnipsExandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
"}}}

"{{{ tex-conceal settings
set conceallevel=1
let g:tex_conceal='abdmg'
"}}}

"{{{ Neoterm
let g:neoterm_default_mod='vertical'
let g:neoterm_direct_open_repl=1
"}}}

"{{{ FZF
let $FZF_DEFAULT_COMMAND = 'fd -H'
" }}}

""{{{ ALE
"let g:ale_fixers = {
"\	'*': ['remove_trailing_lines', 'trim_whitespace'],
"\	'python': ['autopep8']
"\}
"let g:ale_linters = {
"\	'python': ['pylint'],
"\	'latex': ['lacheck']
"\}
"let g:ale_fix_on_save = 1
"let g:ale_open_list = 0
""}}}

function Html()
	let texto = execute('w ! pandoc -s -t html | xclip -t text/html -selection clipboard')
	return texto
endfunction

"{{{ Keybindings
"{{{ Movendo nos splits
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h
nnoremap <c-Down> <c-w>j
nnoremap <c-Up> <c-w>k
nnoremap <C-Left> <c-w>h
nnoremap <C-Right> <c-w>l
"}}}
nnoremap <c-L> <c-w>L
nnoremap <c-H> <c-w>H
"{{{ FZF
nnoremap <leader>ff :Files ~<cr>
nnoremap <leader>f. :Files ./<cr>
nnoremap <leader>fs :Gstatus<cr>
nnoremap <leader>fb :Buffers<cr>
"}}}
"{{{ Movendo com [x
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [l :lprevious<CR>
nnoremap <silent> ]l :lnext<CR>
"}}}
"{{{ Neoterm
map <leader><leader> <Plug>(neoterm-repl-send)ap
map <leader>p <Plug>(neoterm-repl-send)
"}}}
tnoremap <esc> <c-\><c-n>
nnoremap <leader>h :call Html()<cr>
nnoremap <leader>w :w <cr>:so % <cr>
nmap <Leader>z <Plug>(Limelight)
xmap <Leader>z <Plug>(Limelight)
nnoremap <leader>x :Limelight0.8<cr>
nnoremap <leader>c :Limelight!<cr>
"{{{ Remove pageup e pagedown de todos os modos
nnoremap <PageUp> <Nop>
nnoremap <PageDown> <Nop>
inoremap <PageUp> <Nop>
inoremap <PageDown> <Nop>
vnoremap <PageUp> <Nop>
vnoremap <PageDown> <Nop>
tnoremap <PageUp> <Nop>
tnoremap <PageDown> <Nop>
cnoremap <PageUp> <Nop>
cnoremap <PageDown> <Nop>
"}}}
"}}}
