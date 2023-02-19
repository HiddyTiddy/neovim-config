local M = {}

local ft_handlers = {
    markdown = function(_)
        -- local line = vim.api.nvim_get_current_line()
        -- local link_pattern = "%[[^%]]+%]%(([^%)]+)%)"
        -- return string.match(argument, link_pattern)
        local link = require("utils").md_link_around_cursor()
        return link
    end,
}

function M.open()
    local argument = vim.fn.expand("<cWORD>")
    local filetype = vim.bo.filetype

    if ft_handlers[filetype] ~= nil then
        local c = ft_handlers[filetype](argument)
        if c ~= nil and c ~= "" then
            argument = c
        end
    end

    vim.fn.system({ "open", argument })
    -- vim.cmd([[:!open <c-r><c-a><cr>]])
end

function M.setup(config)
    if config ~= nil and config.handlers ~= nil then
        for filetype, handler in pairs(config.handlers) do
            ft_handlers[filetype] = handler
        end
    end

    vim.cmd([[
command Open lua require("hyde.various.open").open()
]])
end

return M
