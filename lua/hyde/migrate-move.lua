local api = vim.api
local fn = vim.fn
local buf, win
local M = {}

local program = "migrate_move"
local up_template
local down_template
local dir_path

local function templates()
    local out = ""

    if up_template ~= nil then
        out = "--up " .. up_template .. " "
    end

    if down_template ~= nil then
        out = "--down " .. down_template .. " "
    end

    return out
end

local function dir()
    if dir_path ~= nil then
        return " -p " .. dir_path .. " "
    end
    return ""
end

local function update()
    local result = fn.systemlist(program .. dir() .. templates() .. " list -o")
    for k, v in pairs(result) do
        result[k] = "  " .. v
    end

    api.nvim_buf_set_lines(buf, 0, -1, false, result)
end

local function open_window()
    vim.cmd("vsplit")
    win = api.nvim_get_current_win()
    buf = api.nvim_create_buf(true, true)
    api.nvim_win_set_buf(win, buf)

    api.nvim_buf_set_keymap(buf, "n", "º", "<Esc>:lua require('hyde.migrate-move').move_down()<CR>", { silent = true })
    api.nvim_buf_set_keymap(buf, "n", "∆", "<Esc>:lua require('hyde.migrate-move').move_up()<CR>", { silent = true })
    api.nvim_buf_set_keymap(buf, "n", "J", "<Esc>:lua require('hyde.migrate-move').move_down()<CR>", { silent = true })
    api.nvim_buf_set_keymap(buf, "n", "K", "<Esc>:lua require('hyde.migrate-move').move_up()<CR>", { silent = true })
    update()
end

local function move_up()
    local lineNum = api.nvim_win_get_cursor(win)[1]
    if lineNum == 1 then
        return
    end
    fn.systemlist(program .. dir() .. templates() .. " up " .. (lineNum - 1))
    api.nvim_win_set_cursor(win, { lineNum - 1, 0 })

    update()
end

local function move_down()
    local lineNum = api.nvim_win_get_cursor(win)[1]
    local height = vim.api.nvim_buf_line_count(buf)
    if lineNum == height then
        return
    end
    fn.systemlist(program .. dir() .. templates() .. " down " .. (lineNum - 1))
    api.nvim_win_set_cursor(win, { lineNum + 1, 0 })

    update()
end

M.setup = function(config)
    if config.program ~= nil then
        program = config.program
    end

    if config.up_template ~= nil then
        up_template = config.up_template
    end

    if config.down_template ~= nil then
        down_template = config.down_template
    end

    if config.dir_path ~= nil then
        dir_path = config.dir_path
    end
end

M.open_window = open_window
M.update = update
M.move_up = move_up
M.move_down = move_down

return M
