-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.api.nvim_create_autocmd('LspAttach', {
  desc = "LSP keybindings",
  callback = function()
    local opts = { noremap = true, silent = true }
    local function map(m, a, b, d)
      vim.api.nvim_buf_set_keymap(0, m, a, b, vim.tbl_extend(
        'keep', opts, { desc = d }
      ))
    end

    map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', "Goto definition")
    map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', "Find implementations")
    map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', "Find references")
    map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', "Hover")
    map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', "Signature help")
    map('v', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', "LSP Format")
    map('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', "Rename")
    map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', "Code actions")
    map('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', "Diagnostics float")
    map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', "Goto next diagnostic")
    map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', "Goto previous diagnostic")
  end
})


--{{{ Movendo nos splits
local function splits_map(a, b, d)
  vim.api.nvim_set_keymap('n', a, b, vim.tbl_extend(
    'keep', { noremap = true }, { desc = d }
  ))
end

splits_map('<c-h>', '<cmd>navigatorleft<cr>', "navigator move left")
splits_map('<c-j>', '<cmd>navigatordown<cr>', "navigator move down")
splits_map('<c-k>', '<cmd>navigatorup<cr>', "navigator move up")
splits_map('<c-l>', '<cmd>navigatorright<cr>', "navigator move right")
splits_map('<c-p>', '<cmd>navigatorprevious<cr>', "navigator move previous")
splits_map('<c-left>', '<c-w>h', "move to split left")
splits_map('<c-down>', '<c-w>j', "move to split down")
splits_map('<c-up>', '<c-w>k', "move to split up")
splits_map('<c-right>', '<c-w>l', "move to split right")
--}}}

--{{{ Movendo entre bufers
vim.api.nvim_set_keymap('n', '[B', ':bprevious<cr>', { silent = true })
vim.api.nvim_set_keymap('n', ']B', ':bnext<cr>', { silent = true })
--}}}

--{{{ Telescope
vim.api.nvim_set_keymap('n', '<Space>ff', ':Telescope find_files<cr>', {})
vim.api.nvim_set_keymap('n', '<Space>fd', ':Telescope fd<cr>', {})
vim.api.nvim_set_keymap('n', '<Space>fl', ':Telescope loclist<cr>', {})
vim.api.nvim_set_keymap('n', '<Space>fb', ':Telescope buffers<cr>', {})
--}}}


vim.opt.writebackup     = false
vim.opt.termguicolors   = true
vim.opt.autoindent      = true -- maintain indent of current line
vim.opt.backspace       = 'indent,start,eol' -- allow unrestricted backspacing in insert mode
vim.opt.belloff         = 'all' -- never ring the bell for any reason
vim.opt.clipboard       = 'unnamedplus' -- Sincronizar com sistema
vim.opt.completeopt     = { 'menu', 'menuone', 'noselect' }
vim.opt.cursorline      = true -- highlight current line
vim.opt.conceallevel    = 2 -- Hide * markup for bold and italic, but not markers with substitutions
vim.opt.emoji           = false -- don't assume all emoji are double width
vim.opt.expandtab       = true -- always use spaces instead of tabs
vim.opt.fillchars       = {
  diff = '∙', -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
  eob  = ' ', -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0)
  fold = '·', -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
  vert = '┃', -- BOX DRAWINGS HEAVY VERTICAL
}
-- vim.opt.foldlevelstart = 99                                -- start unfolded
vim.opt.foldmethod      = 'marker' -- not as cool as syntax, but faster
vim.opt.formatoptions   = vim.opt.formatoptions + 'j' -- remove comment leader when joining comment lines
vim.opt.formatoptions   = vim.opt.formatoptions + 'n' -- smart auto-indenting inside numbered lists
vim.opt.hidden          = true -- hide buffers with unsaved changes
vim.opt.inccommand      = 'split' -- live preview of :s results
vim.opt.laststatus      = 2 -- always show status line
vim.opt.list            = true -- show whitespace
vim.opt.listchars       = {
  nbsp     = '⦸', -- Non-break space
  extends  = '»', -- Em caso de não ter wrap
  precedes = '«', -- Em caso de não ter wrap
  tab      = '▷┅', -- Tab
  trail    = '•', -- Espaços em branco no final da linha
}
vim.opt.modelines       = 5 -- Quantas linhas procurar por modeline
vim.opt.mouse           = 'a' -- Mouse
vim.opt.scrolloff       = 10 -- Deixar 10 linhas no topo e em baixo
vim.opt.shell           = 'zsh' -- shell to use for `!`, `:!`, `system()` etc.
vim.opt.shiftround      = false -- don't always indent by multiple of shiftwidth
vim.opt.shiftwidth      = 2 -- spaces per tab (when shifting)
vim.opt.shortmess       = vim.opt.shortmess + 'A' -- ignore annoying swapfile messages
vim.opt.shortmess       = vim.opt.shortmess + 'O' -- file-read message overwrites previous
vim.opt.shortmess       = vim.opt.shortmess + 'c' -- completion messages
vim.opt.showbreak       = '↳ ' -- Final da linha em wrap
vim.opt.showcmd         = false -- don't show extra info at end of command line
vim.opt.smarttab        = true -- <tab>/<BS> indent/dedent in leading whitespace
vim.opt.splitbelow      = true -- Split para baixo
vim.opt.splitright      = true -- Split para direita
vim.opt.swapfile        = false -- Não criar swap files
vim.opt.switchbuf       = 'usetab' -- try to reuse windows/tabs when switching buffers
vim.opt.tabstop         = 2 -- spaces per tab
vim.opt.updatecount     = 80 -- update swapfiles every 80 typed chars
vim.opt.updatetime      = 2000 -- CursorHold interval
vim.opt.virtualedit     = 'block' -- Cursor anda por colunas virtuais
vim.opt.visualbell      = true -- stop annoying beeping for non-error errors
vim.opt.whichwrap       = 'b,h,l,s,<,>,[,],~' -- Permite passar de linhas com estes comandos
vim.opt.timeoutlen      = 500
vim.opt.ttimeoutlen     = 10
vim.opt.spell           = true                          -- Enable spell checking
vim.opt.spelllang       = { "en_us", "pt_br", "de_de" } -- Use US English, Portuguese (Brazil), and German
vim.g.python3_host_prog = '/bin/python3'
vim.opt.number          = true                          -- Show line numbers

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
  diff = {
    -- diff command <d> can be one of:
    -- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
    --   so you can have a different command for diff <d>
    -- * git: will run git diff and open a buffer with filetype git
    -- * terminal_git: will open a pseudo terminal with git diff
    -- * diffview.nvim: will open Diffview to show the diff
    cmd = "git",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

vim.cmd.colorscheme("onedark")
