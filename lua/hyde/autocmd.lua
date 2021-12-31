-- vim.cmd [[
--     autocmd BufEnter,BufWinEnter,BufWritePost,InsertLeave,TabEnter *.rs
-- \ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
--
-- ]]

-- vim.cmd [[ autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs :lua require'lsp_extensions'.inlay_hints{ prefix = '=>', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} } ]]

-- autocmd BufEnter,BufWinEnter *.rs :RustSetInlayHints
vim.cmd [[
    autocmd BufEnter,BufWinEnter *.rs :set makeprg=cargo
    autocmd BufEnter,BufWinEnter *.dot :set makeprg=dot\ -Tsvg\ %\ -o\ %<.svg
]]
vim.cmd([[
    autocmd BufEnter *.png,*.jpg,*gif exec "! imgcat ".expand("%") | :bw
]])

vim.cmd([[
    au Filetype markdown nnoremap <buffer> <leader>ps :PresentingStart<CR>
    au Filetype markdown nnoremap <buffer> <F12> :.!toilet -w 200 -f term -F border<CR>
]])
