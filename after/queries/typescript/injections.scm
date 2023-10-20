; extends

; (
;   (string_fragment) @injection.content
;   (#set! injection.language "rust")
; )

; https://github.com/nvim-treesitter/nvim-treesitter/blob/master/queries/ecma/injections.scm

(((template_string) @_template_string
 (#match? @_template_string "^`#gql")) @graphql)


(((template_string) @_template_string
 (#match? @_template_string "^`\\<")) @html)

(pair
  key: (property_identifier) @_name
    (#eq? @_name "template")
  value: (template_string) @html
)


;
; (
;   (
;     script_element
;     (raw_text) @injection.content
;   )
;   (
;     #set! injection.language "javascript"
;   )
; )
