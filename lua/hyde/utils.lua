local M = {}

M.get_range = function(start_mark, end_mark)
    local s_start = vim.fn.getpos(start_mark)
    local s_end = vim.fn.getpos(end_mark)

    local n_lines = math.abs(s_end[2] - s_start[2]) + 1
    local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)

    lines[1] = string.sub(lines[1], s_start[3], -1)
    if n_lines == 1 then
        lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
    else
        lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
    end
    return table.concat(lines, "\n")
end

M.get_visual_range = function()
    local s_start = vim.fn.getpos("'<")
    local s_end = vim.fn.getpos("'>")

    local n_lines = math.abs(s_end[2] - s_start[2]) + 1
    local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)

    lines[1] = string.sub(lines[1], s_start[3], -1)
    if n_lines == 1 then
        lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
    else
        lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
    end
    return table.concat(lines, "\n")
end

M.buf_map = function(bufnr, mode, trigger, command, opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, mode, trigger, command, opts or { silent = true })
    opts = opts or { silent = true }
    opts.buffer = bufnr
    vim.keymap.set(mode, trigger, command, opts)
end

return M
