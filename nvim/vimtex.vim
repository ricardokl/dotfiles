" Vimtex

let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
" let g:vimtex_quickfix_enabled
let g:vimtex_compiler_latexmk = { 'options' : [ '-pdf', '-pdflatex="xelatex --shell-escape %O %S"', '-verbose', '-file-line-error', '-synctex=1', '-interaction=nonstopmode',  ] }
let g:vimtex_complete_enabled = 1
let g:vimtex_complete_close_braces = 1
let g:vimtex_complete_ignore_case = 1
let g:vimtex_complete_smart_case = 1
" let g:vimtex_compiler_progname='nvr'
