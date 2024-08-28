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
