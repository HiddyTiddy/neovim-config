-- vim.cmd [[
--     autocmd BufEnter,BufWinEnter,BufWritePost,InsertLeave,TabEnter *.rs
-- \ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
--
-- ]]

-- vim.cmd [[ autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs :lua require'lsp_extensions'.inlay_hints{ prefix = '=>', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} } ]]

-- vim.cmd [[
-- autocmd BufEnter,BufWinEnter *.rs :RustSetInlayHints
-- ]]
