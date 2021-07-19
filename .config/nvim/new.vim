set nocompatible

"{{{ Plugins
call plug#begin('~/.config/nvim/plugged/')
"
" Aparência
Plug 'bling/vim-airline'
Plug 'dracula/vim'
Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify'
" Utilitários
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'voldikss/vim-floaterm'
Plug 'vimwiki/vimwiki'
Plug 'neomake/neomake'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}
" Latex
Plug 'lervag/vimtex'
Plug 'KeitaNakamura/tex-conceal.vim'
" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Python
Plug 'psf/black', { 'branch': 'stable' }
Plug 'jeetsukumaran/vim-pythonsense'
"
Plug 'ryanoasis/vim-devicons'
call plug#end()
"}}}

"{{{ Sourcing
source ~/dotfiles/.config/nvim/startscreen.vim
source ~/dotfiles/.config/nvim/floaterm.vim
source ~/dotfiles/.config/nvim/vimtex.vim
source ~/dotfiles/.config/nvim/ultisnips.vim
source ~/dotfiles/.config/nvim/texconceal.vim
source ~/dotfiles/.config/nvim/fzf.vim
source ~/dotfiles/.config/nvim/indentline.vim
source ~/dotfiles/.config/nvim/vimwiki.vim
luafile ~/dotfiles/.config/nvim/treesitter.lua
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
command! LS Buffers
command! W w
command! Wq wq
command! Out CocList outline
command! Nome echo expand('%:p')
command! VT vsp | terminal
command! T sp | terminal
"}}}

"{{{ Au groups
au filetype vimwiki silent! iunmap <buffer> <Tab>

augroup Firenvim
    autocmd! BufEnter github.com_*.txt set filetype=markdown
augroup END

augroup markdown
	autocmd FileType markdown let b:surround_{char2nr('b')} = "**\r**"
	autocmd FileType markdown let b:surround_{char2nr('e')} = "$$\n\r\n$$"
	autocmd FileType markdown let b:surround_{char2nr('$')} = "$\r$"
	autocmd Filetype markdown nnoremap <leader>cs :FloatermNew cht.sh --shell markdown<cr>
	let g:markdown_fenced_languages = ['python', 'bash', 'latex']
 augroup END

augroup python
	autocmd Filetype python nnoremap <leader>cs :FloatermNew cht.sh --shell python<cr>
	autocmd Filetype python nnoremap <leader>fl :w !flake8
augroup END
"}}}

lua << EOF
require'lspconfig'.jedi_language_server.setup{}
require'lspconfig'.texlab.setup{}
require'lspconfig'.vimls.setup{}

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;
  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    ultisnips = true;
    emoji = true;
  };
}
EOF
