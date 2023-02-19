; extends

(
  (pair
    key: (string (string_content) @_scripts)
    value: (object
      (pair
        value: (string (string_content) @bash)
      )
    )
  ) @capture
  (#eq? @_scripts "scripts")
)

