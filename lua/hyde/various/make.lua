local M = {}

local api = vim.api
local job_id
local win, buf

function M.make(...)
    local lines = { "" }
    --[[ local winnr = vim.fn.win_getid() ]]
    --[[ local bufnr = vim.api.nvim_win_get_buf(winnr) ]]

    local makeprg = vim.o.makeprg
    if not makeprg then
        return
    end

    for i = 1, select("#", ...) do
        makeprg = makeprg .. " " .. select(i, ...)
    end

    local cmd = vim.fn.expandcmd(makeprg)
    local function on_event(_, data, event)
        if event == "stdout" or event == "stderr" then
            if data then
                vim.list_extend(lines, data)
            end
        end

        if event == "exit" then
            if win == nil or buf == nil then
                vim.cmd("vsplit")
                win = api.nvim_get_current_win()
                buf = api.nvim_create_buf(true, true)
                api.nvim_win_set_buf(win, buf)
                --[[ vim.fn.setqflist({}, " ", { ]]
                --[[     title = cmd, ]]
                --[[     lines = lines, ]]
                --[[     efm = vim.api.nvim_buf_get_option(bufnr, "errorformat"), ]]
                --[[ }) ]]
                --[[ vim.api.nvim_command("doautocmd QuickFixCmdPost") ]]
            end
            api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        end
    end

    print("[Make] " .. makeprg)
    job_id = vim.fn.jobstart(cmd, {
        on_stderr = on_event,
        on_stdout = on_event,
        on_exit = on_event,
        stdout_buffered = true,
        stderr_buffered = true,
    })
end

M.kill = function()
    vim.fn.jobstop(job_id)
end

vim.cmd([[
command -nargs=* -complete=file Make lua require("hyde.various.make").make(<f-args>)
]])

return M
