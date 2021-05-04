set nocompatible

"{{{ Plugins
call plug#begin('~/.config/nvim/plugged/')
"
" Aparência
Plug 'bling/vim-airline'
Plug 'dracula/vim'
Plug 'haya14busa/is.vim'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/goyo.vim'
Plug 'mhinz/vim-startify'
" Utilitários
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'voldikss/vim-floaterm'
Plug 'preservim/tagbar'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf', {'branch': 'release'}
Plug 'vimwiki/vimwiki'
" Latex
Plug 'lervag/vimtex'
Plug 'KeitaNakamura/tex-conceal.vim'
" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Python
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
"
Plug 'ryanoasis/vim-devicons'
call plug#end()
"}}}

"{{{ Sourcing
source ~/dotfiles/.config/nvim/startscreen.vim
source ~/dotfiles/.config/nvim/netrw.vim
source ~/dotfiles/.config/nvim/floaterm.vim
source ~/dotfiles/.config/nvim/vimtex.vim
source ~/dotfiles/.config/nvim/ultisnips.vim
source ~/dotfiles/.config/nvim/texconceal.vim
source ~/dotfiles/.config/nvim/fzf.vim
source ~/dotfiles/.config/nvim/markdownpreview.vim
source ~/dotfiles/.config/nvim/indentline.vim
source ~/dotfiles/.config/nvim/coc.vim
source ~/dotfiles/.config/nvim/pymode.vim
source ~/dotfiles/.config/nvim/firenvim.vim
source ~/dotfiles/.config/nvim/vimwiki.vim
source ~/dotfiles/.config/nvim/settings.vim
source ~/dotfiles/.config/nvim/keybindings.vim
"}}}

"{{{ Funções
function! Html()
	let texto = execute('w ! pandoc -s -t html | xclip -t text/html -selection clipboard')
	return texto
endfunction
"}}}

"{{{ Comandos
command! Ls Buffers
command! Out CocList outline
command! Nome echo expand('%:p')
"}}}

"{{{ Au groups
augroup Firenvim
    autocmd! BufEnter github.com_*.txt set filetype=markdown
    autocmd! BufEnter mail.gmail.com_*.txt set filetype=markdown
augroup END

augroup markdown
	autocmd FileType markdown let b:surround_{char2nr('b')} = "**\r**"
	autocmd FileType markdown let b:surround_{char2nr('e')} = "$$\n\r\n$$"
	autocmd FileType markdown let b:surround_{char2nr('$')} = "$\r$"
	let g:markdown_fenced_languages = ['python', 'bash', 'latex']
 augroup END
"}}}
