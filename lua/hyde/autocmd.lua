-- vim.cmd [[
--     autocmd BufEnter,BufWinEnter,BufWritePost,InsertLeave,TabEnter *.rs
-- \ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
--
-- ]]

-- vim.cmd [[ autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs :lua require'lsp_extensions'.inlay_hints{ prefix = '=>', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} } ]]

local function create_augroup(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end

local function autocmd(augroup, events, pattern, callback)
    if type(pattern) == "string" then
        pattern = { pattern }
    end
    if type(events) == "string" then
        events = { events }
    end
    local opts = {
        group = augroup,
        pattern = pattern,
    }
    if type(callback) == "string" and string.sub(callback, 1, 1) == ":" then
        opts.command = string.sub(callback, 2)
    else
        opts.callback = callback
    end

    vim.api.nvim_create_autocmd(events, opts)
end

-- autocmd BufEnter,BufWinEnter *.rs :RustSetInlayHints
local make_prgs = create_augroup("MakePrgs")
autocmd(make_prgs, { "BufEnter", "BufWinEnter" }, "*.rs", ":set makeprg=cargo")
autocmd(make_prgs, { "BufEnter", "BufWinEnter" }, "*.dot", [[:set makeprg=dot\ -Tsvg\ %\ -o\ %<.svg]])
autocmd(make_prgs, { "BufEnter", "BufWinEnter" }, "*.ts", [[:set makeprg=deno\ run\ %]])
-- vim.cmd([[
--     autocmd BufEnter,BufWinEnter *.rs :set makeprg=cargo
--     autocmd BufEnter,BufWinEnter *.dot :set makeprg=dot\ -Tsvg\ %\ -o\ %<.svg
--     autocmd BufEnter,BufWinEnter *.ts :set makeprg=deno\ run\ %
-- ]])
-- autocmd(make_prgs, "BufEnter", {"*.png", "*.jpg", "*.gif"}, "<cmd>!imgcat ")
vim.cmd([[
    autocmd BufEnter *.png,*.jpg,*gif exec "! icat ".expand("%") | :bw
]])

vim.cmd([[
    au Filetype markdown nnoremap <buffer> <leader>ps :PresentingStart<CR>
    au Filetype markdown nnoremap <buffer> <F12> :.!toilet -w 200 -f term -F border<CR>
    " au Filetype markdown setlocal conceallevel=2
]])

vim.cmd([[
    au Filetype lua :setlocal keywordprg=:help
]])

-- https://this-week-in-neovim.org/2023/Jan/02#tips
-- seek to last position before exiting
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- vim.cmd([[
--     autocmd BufWritePre *.ts execute "silent %!npx prettier --stdin-filepath '" . expand('%:p') . "'"
-- ]])

-- vim.cmd([[
--     autocmd BufWritePre *.ts lua vim.lsp.buf.formatting(nil, 1000)
-- ]])
