-- write serverfile

local M = {}

M.write_serverfile = function()
    local file = io.open("/tmp" .. "/" .. "/vimtexserver.txt", "w")
    if file == nil then
        return
    end

    file:write(vim.v.servername)

    file:close()
end

-- vim.g.vimtex_view_general_viewer = "/Applications/Skim.app/Contents/SharedSupport/displayline"
-- vim.g.vimtex_view_general_viewer = "/usr/local/bin/zathura"
-- vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_view_method = "sioyek"
-- vim.g.vimtex_view_general_options = "-r @line @pdf @tex"

M.update_skim = function()
    local out = vim.b.vimtex.out
    local src_file_path = vim.fn.expand("%p")
    local cmd = { "-r" }

    local handle = io.popen("procs Skim")
    if handle == nil then
        return
    end
    local result = string.len(handle:read("*a"))
    handle:close()

    if result ~= 0 then
        cmd[#cmd + 1] = "-g"
    end

    for _, v in ipairs({ vim.fn.line("."), out, src_file_path }) do
        table.insert(cmd, v)
    end

    vim.loop.spawn(vim.g.vimtex_view_general_viewer, { args = cmd })
end

local id = vim.api.nvim_create_augroup("latexopts", { clear = false })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.tex" },
    callback = function(ev)
        vim.api.nvim_buf_set_keymap(ev.buf, "n", "j", "gj", {})
        vim.api.nvim_buf_set_keymap(ev.buf, "n", "k", "gk", {})
        vim.opt_local.spell = true
        vim.opt_local.wrap = true
        vim.opt_local.breakindent = true
        vim.opt_local.linebreak = true
    end,
    desc = "sets document writing options",
    group = id,
})

-- vim.cmd([[
-- augroup vimtex_mac
--     autocmd!
--     autocmd User VimtexEventCompileSuccess lua require('hyde.latex').update_skim()
-- augroup END
-- ]])

-- TODO fix this
-- vim.cmd([[
-- augroup vimtex_mac
--     autocmd!
--     autocmd User VimtexEventCompileSuccess :silent exec "!~/.config/nvim/szathura.sh %:r.pdf" line('.') col('.') "% > /dev/null"
-- augroup END
-- ]])

return M
