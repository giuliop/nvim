" Vim additional javascript syntax
"

syntax region  javaScriptFuncDef matchgroup=Identifier start="function" matchgroup=None end=")" contains=javaScriptFuncArg keepend
syntax match  javaScriptFuncArg "([^()]*)" contains=javaScriptParens,javaScriptFuncComma contained
syntax match   javaScriptBraces       "[{}\[\]]"
syntax match   javaScriptParens       "[()]"
syntax match  javaScriptFuncComma /,/ contained
