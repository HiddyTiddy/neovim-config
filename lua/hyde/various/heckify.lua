local get_range = require("hyde.utils").get_range

local M = {}

local function replace_text(start_mark, finish_mark, lines)
    local start = vim.api.nvim_buf_get_mark(0, start_mark)
    local finish = vim.api.nvim_buf_get_mark(0, finish_mark)

    local old_lines = finish[1] - start[1] + 1

    if old_lines < #lines then
        assert(false, "not implemented")
    elseif old_lines == #lines then
        local line = vim.api.nvim_buf_get_lines(0, start[1] - 1, start[1], false)[1]
        local e = finish[2]
        if start[1] ~= finish[1] then
            e = #line + 1
        end

        local new_first = string.sub(line, 1, start[2]) .. lines[1] .. string.sub(line, e + 2, #line + 1)
        vim.api.nvim_buf_set_lines(0, start[1] - 1, start[1], false, { new_first })

        assert(#lines == 1, "todo")
        -- for i = 2, #lines do
        --
        -- end
    else
        assert(false, "not implemented")
    end
end

M.heckify = function(target_case)
    local old_func = vim.go.operatorfunc -- backup previous reference
    -- set a globally callable object/function
    _G.heckify = function()
        -- the content covered by the motion is between the [ and ] marks, so get those

        local text = get_range("'[", "']")
        text = text:gsub("\\", "\\\\")
        text = text:gsub('"', '\\"')

        local result = vim.fn.systemlist("heckifier -k -t " .. target_case .. " " .. '"' .. text .. '"')

        replace_text("[", "]", result)

        vim.go.operatorfunc = old_func -- restore previous opfunc
        -- _G.heckify = nil -- deletes itself from global namespace
    end
    vim.go.operatorfunc = "v:lua.heckify"
    vim.api.nvim_feedkeys("g@", "n", false)
end

local maps = {
    { "s", "snek" },
    { "S", "shouty-snek" },
    { "c", "lower-camel" },
    { "C", "upper-camel" },
    { "k", "kebab" },
    { "K", "shouty-kebab" },
    { "t", "title" },
    { "u", "lower" },
    { "U", "upper" },
}

for _, map in ipairs(maps) do
    vim.api.nvim_set_keymap(
        "n",
        "gz" .. map[1],
        "<cmd>lua require('hyde.various.heckify').heckify('" .. map[2] .. "')<CR>",
        { noremap = true }
    )
end

return M
