; extends


(
  field_expression
  value: (macro_invocation
    macro: (scoped_identifier name: (identifier) @__sqlxquery)
    (token_tree (raw_string_literal) @sql)
  )
  (#eq? @__sqlxquery "query")
)

(
  field_expression
  value: (macro_invocation
    macro: (scoped_identifier name: (identifier) @__sqlxquery)
    (token_tree (raw_string_literal) @sql)
  )
  (#eq? @__sqlxquery "query_as")
)
