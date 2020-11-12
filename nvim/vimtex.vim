" Vimtex

let g:vimtex_enabled = 1
let g:tex_flavor='latex'
let g:vimtex_compiler_enabled = 1
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_view_method='zathura'
let g:vimtex_fold_enabled = 1
let g:vimtex_quickfix_enabled = 1
let g:vimtex_quickfix_mode = 0
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_complete_enabled = 0
" let g:vimtex_complete_close_braces = 1
" let g:vimtex_complete_ignore_case = 1
" let g:vimtex_complete_smart_case = 1
" let g:vimtex_compiler_progname='nvr'
let g:vimtex_compiler_latexmk = {
    \ 'executable' : 'latexmk',
    \ 'callback' : 1,
    \ 'continuous' : 1,
    \ 'options' : [
    \   '-pdf', 
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ], 
    \}
" let g:vimtex_toc_custom_matchers = [
"     \ { 'title' : 'My Custom Environment',
"     \   're' : '\v^\s*\\begin\{mycustomenv\}' }
"     \]
