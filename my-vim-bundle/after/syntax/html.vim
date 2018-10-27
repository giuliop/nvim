" Vim syntax file
" Adapted from: https://gist.github.com/2640645 and https://gist.github.com/2640637"
"

syntax case match

syntax region TriplePar matchgroup=NONE start="{{{" end="}}}" containedin=ALLBUT,Comment
syntax region DoublePar matchgroup=NONE start="{{" end="}}" containedin=ALLBUT,Comment
syntax region Comment matchgroup=NONE start="/\*" end="\*/" containedin=DoublePar,TriplePar

highlight link doublePar Visual

" {{{ Highlight erroneous whitespace
" Lifted from http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red

" Show trailing whitespace:
syn match ExtraWhitespace "\s\+$"

" Show trailing whitespace and spaces before a tab:
syn match ExtraWhitespace "\s\+$\| \+\ze\t"

" Show tabs that are not at the start of a line:
syn match ExtraWhitespace "[^\t]\zs\t\+" containedin=ALL

" Show spaces used for indenting (use only tabs for indenting).
"syn match ExtraWhitespace "^\t*\zs \+" containedin=ALL
" }}}
