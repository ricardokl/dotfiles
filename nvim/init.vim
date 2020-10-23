set nocompatible

"{{{ Plugins
call plug#begin('~/.config/nvim/plugged/')
"
" Generic
Plug 'bling/vim-airline'
Plug 'dracula/vim'
Plug 'haya14busa/is.vim'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/goyo.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'junegunn/limelight.vim'
Plug 'mhinz/vim-startify'
" Utilities
Plug 'dhruvasagar/vim-table-mode'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'neoclide/coc-snippets'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'voldikss/vim-floaterm'
Plug 'kassio/neoterm'
Plug 'ludovicchabant/vim-gutentags'
Plug 'preservim/tagbar'
Plug 'neoclide/coc.nvim', {'branch': 'releae'}
Plug 'iamcco/coc-vimlsp'
Plug 'neoclide/coc-yank'
Plug 'neoclide/coc-json'
Plug 'neoclide/coc-html'
" Latex
Plug 'lervag/vimtex'
Plug 'KeitaNakamura/tex-conceal.vim'
Plug 'fannheyward/coc-texlab'
" Markdown
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Python
Plug 'neoclide/coc-python'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
"
Plug 'ryanoasis/vim-devicons'
call plug#end()
"}}}

"{{{ Sourcing
source ~/dotfiles/nvim/settings.vim
source ~/dotfiles/nvim/keybindings.vim
source ~/dotfiles/nvim/startscreen.vim
source ~/dotfiles/nvim/netrw.vim
source ~/dotfiles/nvim/floaterm.vim
source ~/dotfiles/nvim/vimtex.vim
source ~/dotfiles/nvim/ultisnips.vim
source ~/dotfiles/nvim/texconceal.vim
source ~/dotfiles/nvim/neoterm.vim
source ~/dotfiles/nvim/fzf.vim
source ~/dotfiles/nvim/markdownpreview.vim
source ~/dotfiles/nvim/indentline.vim
source ~/dotfiles/nvim/coc.vim
"}}}

"{{{ Funções
function! Html()
	let texto = execute('w ! pandoc -s -t html | xclip -t text/html -selection clipboard')
	return texto
endfunction
"}}}

"{{{ Comandos
command! Ls Buffers
command! Tab tabnew
"}}}

"{{{ Au groups
augroup markdown
	autocmd FileType markdown let b:surround_{char2nr('b')} = "**\r**"
	autocmd FileType markdown let b:surround_{char2nr('e')} = "$$\n\r\n$$"
	autocmd FileType markdown let b:surround_{char2nr('$')} = "$\r$"
augroup END
"}}}
