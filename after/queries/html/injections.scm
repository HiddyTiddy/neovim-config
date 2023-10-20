; extends

(
  (attribute
    (attribute_name ) @_attr_name
    (quoted_attribute_value
      (attribute_value ) @javascript
    )
  )
  (#match? @_attr_name "^on")
)
