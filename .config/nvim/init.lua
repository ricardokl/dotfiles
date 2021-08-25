--{{{ Plugins
local Plug = vim.fn['plug#']
vim.call('plug#begin','~/.config/nvim/plugged/')
--
-- Aparência
Plug 'dracula/vim'
Plug 'bling/vim-airline'
Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify'
-- Utilitários
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'voldikss/vim-floaterm'
Plug 'vimwiki/vimwiki'
Plug 'neovim/nvim-lspconfig'
-- Plug 'hrsh7th/nvim-compe'
Plug('ms-jpq/coq_nvim', {['branch'] = 'coq'})
Plug('nvim-treesitter/nvim-treesitter', {['do'] = 'TSUpdate'})
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
-- Latex
Plug 'lervag/vimtex'
-- Git
Plug 'airblade/vim-gitgutter'
--
Plug 'ryanoasis/vim-devicons'
vim.call('plug#end')
--}}}

--{{{ Sourcing
vim.cmd('source /home/ricardo/dotfiles/.config/nvim/augroups.vim')
--}}}

--{{{ Configuração
vim.cmd('filetype indent plugin on')
vim.cmd('syntax on')
vim.cmd('colorscheme dracula')
vim.opt.autoindent     = true                              -- maintain indent of current line
vim.opt.backspace      = 'indent,start,eol'                -- allow unrestricted backspacing in insert mode
vim.opt.belloff        = 'all'                             -- never ring the bell for any reason
vim.opt.clipboard      = 'unnamedplus'                     -- Sincronizar com sistema
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
vim.opt.mouse          = 'a'                               -- Mouse
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
local nvim_lsp = require('lspconfig')
local coq = require('coq')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'vimls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    coq.lsp_ensure_capabilities(),
  }
end

nvim_lsp['texlab'].setup{
  on_attach = on_attach,
  chktex = { onOpenAndSave = true }
}
-- }}}

----{{{ Compe
--require'compe'.setup {
--  documentation = true;
--  source = {
--    path = true;
--    buffer = true;
--    calc = true;
--    nvim_lsp = true;
--    nvim_lua = true;
--    ultisnips = true;
--    emoji = true;
--  };
--}
----}}}

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
        ["]a"] = "@parameter.inner",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]C"] = "@call.outer",
        ["]A"] = "@parameter.inner",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[c"] = "@call.outer",
        ["[a"] = "@parameter.inner",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[C"] = "@call.outer",
        ["[A"] = "@parameter.inner",
      },
    },
  }
}
--}}}

--{{{ Telescope
require'telescope'.setup {
  defaults = {
    color_devicons = true,
    }
  }
--}}}

--{{{ IndentLine
vim.g.indentLine_char = '▏'
--}}}

--{{{ Floaterm
vim.g.floaterm_gitcommit  = 'floaterm'
vim.g.floaterm_autoinsert = 1
vim.g.floaterm_width      = 0.8
vim.g.floaterm_height     = 0.8
vim.g.floaterm_wintitle   = 0
--}}}

--{{{ Vimtex
vim.g.vimtex_enabled                  = 1
vim.g.vimtex_compiler_enabled         = 1
vim.g.vimte_compiler_method           = 'latexmk'
vim.g.vimtex_view_method              = 'zathura'
vim.g.vimtex_quickfix_enabled         = 1
vim.g.vimtex_quickfix_mode            = 0
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_complete_enabled         = 0
vim.g.vimtex_compiler_latexmk         = {
  executable                      = 'latexmk',
  callback                        = 1,
  continuous                      = 1,
  options                         = {
    '-pdf',
    '-verbose',
    '-file-line-error',
    '-synctex = 1',
    '-interaction = nonstopmode'
  }
}
--}}}

--{{{ Vimwiki
vim.g.vimwiki_list       = {{
  path               = '~/mywiki',
  syntax             = 'markdown',
  ext                = '.md'
}}
vim.g.vimwiki_global_ext = 0
--}}}

--{{{ Ultisnips
vim.g.UltisnipsExpandTrigger       = '<tab>'
vim.g.UltisnipsJumpForwardTrigger  = '<tab>'
vim.g.UltisnipsJumpBackwardTrigger = '<s-tab>'
--}}}

--{{{ Starttify
vim.g.startify_session_dir = '~/.config/nvim/session'
vim.g.startify_lists = {
  { type = 'bookmarks', header = {'Bookmarks'}},
  { type = 'files', header = {'Recentes'}},
  { type = 'sessions', header = {'Sessions'}}
}
vim.g.webdevicons_enable_startify = 1
vim.g.startify_bookmarks = {
  { v = '~/dotfiles/.config/nvim/init.lua' },
  { z = '~/dotfiles/.zshrc' },
  { t = '~/Documents/todo.md' }
}
vim.g.startify_files_number = 5
vim.g.startify_fortune_use_unicode = 1
vim.g.startify_padding_left = 5
--}}}

--{{{ Keymaps
vim.g.mapleader = ' '
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
vim.api.nvim_set_keymap('n', '<Space>fd', ':Telescope fd<cr>',{})
vim.api.nvim_set_keymap('n', '<Space>fb', ':Telescope file_browser<cr>',{})
vim.api.nvim_set_keymap('n', '<Space>fl', ':Telescope loclist<cr>',{})
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
