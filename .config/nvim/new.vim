"{{{ Plugins
call plug#begin('~/.config/nvim/plugged/')
"
" Aparência
Plug 'dracula/vim'
Plug 'bling/vim-airline'
Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify'
" Utilitários
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
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
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
" Latex
Plug 'lervag/vimtex'
" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Python
Plug 'psf/black', { 'branch': 'stable' }
"
Plug 'ryanoasis/vim-devicons'
call plug#end()
"}}}

"{{{ Sourcing
source ~/dotfiles/.config/nvim/startscreen.vim
source ~/dotfiles/.config/nvim/floaterm.vim
source ~/dotfiles/.config/nvim/vimtex.vim
source ~/dotfiles/.config/nvim/ultisnips.vim
source ~/dotfiles/.config/nvim/vimwiki.vim
luafile ~/dotfiles/.config/nvim/treesitter.lua
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
command! Nome echo expand('%:p')
command! VT vsp | terminal
command! T sp | terminal
"}}}

"{{{ Au groups
au! TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
au TextYankPost * silent! lua vim.highlight.on_yank()
au filetype vimwiki silent! iunmap <buffer> <Tab>

augroup python
	autocmd Filetype python nnoremap <leader>cs :FloatermNew cht.sh --shell python<cr>
augroup END
"}}}

"{{{ LUA
lua << EOF
--{{{ Configuração
vim.cmd('filetype indent plugin on')
vim.cmd('syntax on')
vim.cmd('colorscheme dracula')
vim.opt.autoindent     = true                              -- maintain indent of current line
vim.opt.backspace      = 'indent,start,eol'                -- allow unrestricted backspacing in insert mode
vim.opt.belloff        = 'all'                             -- never ring the bell for any reason
vim.opt.completeopt    = 'menuone'                         -- show menu even if there is only one candidate
vim.opt.completeopt    = vim.opt.completeopt + 'noselect'  -- don't automatically select canditate
vim.opt.cursorline     = true                              -- highlight current line
vim.opt.emoji          = false                             -- don't assume all emoji are double width
vim.opt.expandtab      = true                              -- always use spaces instead of tabs
vim.opt.fillchars      = {
  diff                 = '∙',                              -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
  eob                  = ' ',                              -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0)
  fold                 = '·',                              -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
  vert                 = '┃',                              -- BOX DRAWINGS HEAVY VERTICAL
}
vim.opt.foldlevelstart = 99                                -- start unfolded
vim.opt.foldmethod     = 'marker'                          -- not as cool as syntax, but faster
vim.opt.formatoptions  = vim.opt.formatoptions + 'j'       -- remove comment leader when joining comment lines
vim.opt.formatoptions  = vim.opt.formatoptions + 'n'       -- smart auto-indenting inside numbered lists
vim.opt.hidden         = true                              -- hide buffers with unsaved changes
vim.opt.inccommand     = 'split'                           -- live preview of :s results
vim.opt.laststatus     = 2                                 -- always show status line
vim.opt.list           = true                              -- show whitespace
vim.opt.listchars      = {
  nbsp                 = '⦸',                              -- Non-break space
  extends              = '»',                              -- Em caso de não ter wrap
  precedes             = '«',                              -- Em caso de não ter wrap
  tab                  = '▷┅',                             -- Tab
  trail                = '•',                              -- Espaços em branco no final da linha
}
vim.opt.modelines      = 5                                 -- Quantas linhas procurar por modeline
vim.opt.scrolloff      = 10                                -- Deixar 10 linhas no topo e em baixo
vim.opt.shell          = 'zsh'                             -- shell to use for `!`, `:!`, `system()` etc.
vim.opt.shiftround     = false                             -- don't always indent by multiple of shiftwidth
vim.opt.shiftwidth     = 2                                 -- spaces per tab (when shifting)
vim.opt.shortmess      = vim.opt.shortmess + 'A'           -- ignore annoying swapfile messages
vim.opt.shortmess      = vim.opt.shortmess + 'O'           -- file-read message overwrites previous
vim.opt.shortmess      = vim.opt.shortmess + 'c'           -- completion messages
vim.opt.showbreak      = '↳ '                              -- Final da linha em wrap
vim.opt.showcmd        = false                             -- don't show extra info at end of command line
vim.opt.smarttab       = true                              -- <tab>/<BS> indent/dedent in leading whitespace
vim.opt.splitbelow     = true                              -- Split para baixo
vim.opt.splitright     = true                              -- Split para direita
vim.opt.swapfile       = false                             -- Não criar swap files
vim.opt.switchbuf      = 'usetab'                          -- try to reuse windows/tabs when switching buffers
vim.opt.tabstop        = 2                                 -- spaces per tab
vim.opt.textwidth      = 80                                -- automatically hard wrap at 80 columns
vim.opt.updatecount    = 80                               -- update swapfiles every 80 typed chars
vim.opt.updatetime     = 2000                             -- CursorHold interval
vim.opt.virtualedit    = 'block'                          -- Cursor anda por colunas virtuais
vim.opt.visualbell     = true                             -- stop annoying beeping for non-error errors
vim.opt.whichwrap      = 'b,h,l,s,<,>,[,],~'              -- Permite passar de linhas com estes comandos
--}}}

--{{{ LSP
require'lspconfig'.jedi_language_server.setup{}
require'lspconfig'.texlab.setup{}
require'lspconfig'.vimls.setup{}
--}}}

--{{{ Compe config
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
--}}}

--{{{ Tree-sitter
require'nvim-treesitter.configs'.setup {
  highlight = { enable = true },
  indent = { enable = true },
  ensure_installed = { "python", "r", "lua", "latex", "bibtex", "bash", "yaml", "json", "html", "css"},
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "gnm",
      node_decremental = "gnd",
      scope_incremental = "gsm"
      },
    },
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim 
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@call.outer",
        ["ic"] = "@call.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        },
      },
    swap = {
       enable = true,
       swap_next = {
         ["<leader>a"] = "@parameter.inner",
       },
       swap_previous = {
         ["<leader>A"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]c"] = "@call.outer",
        ["]a"] = "@parameter.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]C"] = "@call.outer",
        ["]A"] = "@parameter.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[c"] = "@call.outer",
        ["[a"] = "@parameter.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[C"] = "@call.outer",
        ["[A"] = "@parameter.outer",
      },
    },
  }
}
--}}}

--{{{ Telescope
          require'telescope'.setup {
            defaults = {
              border = {},
              borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
              color_devicons = true,
              }
            }
--}}}

--{{{ IndentLine
vim.g.indentLine_char = '▏'
--}}}

--{{{ Keymaps
vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<leader>m', ':Neomake<cr>', { silent = true})
--{{{ Movendo nos splits
vim.api.nvim_set_keymap('n', '<c-h>', '<c-w>h', { noremap = true})
vim.api.nvim_set_keymap('n', '<c-j>', '<c-w>j', { noremap = true})
vim.api.nvim_set_keymap('n', '<c-k>', '<c-w>k', { noremap = true})
vim.api.nvim_set_keymap('n', '<c-l>', '<c-w>l', { noremap = true})
vim.api.nvim_set_keymap('n', '<c-Left>', '<c-w>h',{ noremap = true})
vim.api.nvim_set_keymap('n', '<c-Down>', '<c-w>j',{ noremap = true})
vim.api.nvim_set_keymap('n', '<c-Up>', '<c-w>k',{ noremap = true})
vim.api.nvim_set_keymap('n', '<c-Right>', '<c-w>l',{ noremap = true})
--}}}

--{{{ Telescope
vim.api.nvim_set_keymap('n', '<Space>ff', ':Telescope find_files<cr>',{})
vim.api.nvim_set_keymap('n', '<Space>fg', ':Telescope git_files<cr>',{})
vim.api.nvim_set_keymap('n', '<Space>fb', ':Telescope file_browser<cr>',{})
vim.api.nvim_set_keymap('n', '<Space>bb', ':Telescope buffers<cr>',{})
--}}}

--{{{ Movendo entre bufers
vim.api.nvim_set_keymap('n', '[b', ':bprevious<cr>',{ silent = true })
vim.api.nvim_set_keymap('n', ']b', ':bnext<cr>',{ silent = true })
--}}}

--{{{ Floaterm
vim.api.nvim_set_keymap('n', '<leader>tt', ':FloatermToggle!<cr>',{})
vim.api.nvim_set_keymap('n', '<leader>tk', ':FloatermKill<cr>',{})
vim.api.nvim_set_keymap('n', '<leader>tc', ':FloatermNew! cht.sh --shell<cr>',{})
vim.api.nvim_set_keymap('n', '<leader>tm', ':FloatermNew! cht.sh --shell makdown<cr>',{})
vim.api.nvim_set_keymap('n', '<leader>tp', ':FloatermNew! cht.sh --shell python<cr>',{})
vim.api.nvim_set_keymap('n', '<leader>tl', ':FloatermNew! cht.sh --shell latex<cr>',{})
--}}}

--}}}
EOF
"}}}
