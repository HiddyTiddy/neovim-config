if exists("b:current_syntax")
    finish
endif

syntax keyword tostTodos TODO
syntax keyword tostKeywords toaster

syntax region tostComment start="!!" end="$" contains=tostTodos

syntax region tostString start=/\v"/ skip=/\v\\./ end=/\v"/
syntax region tostString start=/\v'/ skip=/\v\\./ end=/\v'/

highlight default link tostTodos Todo
highlight default link tostKeywords Identifier
highlight default link tostComment Comment
highlight default link tostString String

let b:current_syntax = "tost"


