vim.opt.writebackup   = false
vim.opt.termguicolors = true
vim.opt.autoindent    = true -- maintain indent of current line
vim.opt.backspace     = 'indent,start,eol' -- allow unrestricted backspacing in insert mode
vim.opt.belloff       = 'all' -- never ring the bell for any reason
vim.opt.clipboard     = 'unnamedplus' -- Sincronizar com sistema
vim.opt.completeopt   = { 'menu', 'menuone', 'noselect' }
vim.opt.cursorline    = true -- highlight current line
vim.opt.conceallevel  = 2 -- Hide * markup for bold and italic, but not markers with substitutions
vim.opt.emoji         = false -- don't assume all emoji are double width
vim.opt.expandtab     = true -- always use spaces instead of tabs
vim.opt.fillchars     = {
  diff = '∙', -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
  eob  = ' ', -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0)
  fold = '·', -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
  vert = '┃', -- BOX DRAWINGS HEAVY VERTICAL
}
vim.opt.formatoptions:append('j')
vim.opt.formatoptions:append('n')
-- vim.opt.formatoptions = vim.opt.formatoptions + 'j' -- remove comment leader when joining comment lines
-- vim.opt.formatoptions = vim.opt.formatoptions + 'n' -- smart auto-indenting inside numbered lists
vim.opt.hidden     = true -- hide buffers with unsaved changes
vim.opt.inccommand = 'split' -- live preview of :s results
vim.opt.laststatus = 2 -- always show status line
vim.opt.list       = true -- show whitespace
vim.opt.listchars  = {
  nbsp     = '⦸', -- Non-break space
  extends  = '»', -- Em caso de não ter wrap
  precedes = '«', -- Em caso de não ter wrap
  tab      = '▷┅', -- Tab
  trail    = '•', -- Espaços em branco no final da linha
}
vim.opt.modelines  = 5 -- Quantas linhas procurar por modeline
vim.opt.mouse      = 'a' -- Mouse
vim.opt.scrolloff  = 10 -- Deixar 10 linhas no topo e em baixo
vim.opt.shell      = 'zsh' -- shell to use for `!`, `:!`, `system()` etc.
vim.opt.shiftround = false -- don't always indent by multiple of shiftwidth
vim.opt.shiftwidth = 2 -- spaces per tab (when shifting)
vim.opt.shortmess:append('A')
vim.opt.shortmess:append('O')
vim.opt.shortmess:append('c')
-- vim.opt.shortmess       = vim.opt.shortmess + 'A' -- ignore annoying swapfile messages
-- vim.opt.shortmess       = vim.opt.shortmess + 'O' -- file-read message overwrites previous
-- vim.opt.shortmess       = vim.opt.shortmess + 'c' -- completion messages
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
vim.opt.autoread        = true                          -- Automatically read file when changed on disk
