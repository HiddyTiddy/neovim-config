local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

local colors = {
    red = "#ca1243",
    grey = "#a0a1a7",
    black = "#383a42",
    white = "#f3f3f3",
    light_green = "#83a598",
    orange = "#fe8019",
    green = "#8ec07c",
}

local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = " ", warn = " " },
    colored = false,
    update_in_insert = false,
    always_visible = true,
}

local diff = {
    "diff",
    colored = false,
    symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
    cond = hide_in_width,
}

local mode = {
    "mode",
    fmt = function(str)
        return "-- " .. str .. " --"
    end,
}

local filetype = {
    "filetype",
    icons_enabled = true,
    icon = nil,
}

local branch = {
    "branch",
    icons_enabled = true,
    icon = "",
}

local location = {
    "location",
    padding = 0,
}

-- cool function for progress
local progress = function()
    local buftype = vim.o.ft
    if buftype == "tex" then
        -- if wordcount == nil then
        --     wordcount = require("hyde.various.cache").single(function()
        --         -- still too slow unfortunately
        --         return tostring(vim.fn.system("detex " .. vim.fn.expand("%") .. " | wc -w") + 0)
        --     end)
        -- end
        --
        -- local out= wordcount:get()
        -- return out
        return tostring(vim.fn.wordcount().words)
    else
        local current_line = vim.fn.line(".")
        local total_lines = vim.fn.line("$")
        local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
        -- local chars = { "◜ ", " ◝", " ◞", "◟ "}
        local line_ratio = current_line / total_lines
        local index = math.ceil(line_ratio * #chars)
        return chars[index]
    end
end

-- local spaces = function()
-- 	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
-- end

local function process_sections(sections)
    for name, section in pairs(sections) do
        local left = name:sub(9, 10) < "x"
        for pos = 1, name ~= "lualine_z" and #section or #section - 1 do
            table.insert(section, pos * 2, {
                empty,
                color = { fg = colors.white, bg = colors.white },
            })
        end

        for id, comp in ipairs(section) do
            if type(comp) ~= "table" then
                comp = { comp }
                section[id] = comp
            end
            comp.separator = left and { right = "" } or { left = "" }
        end
    end
    return sections
end

lualine.setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
        always_divide_middle = true,
    },
    sections = process_sections({
        lualine_a = { branch, diagnostics },
        lualine_b = { mode },
        lualine_c = { "filename" },
        -- lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_x = { diff, "encoding", filetype },
        lualine_y = { location },
        lualine_z = { progress },
    }),

    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    -- tabline = {
    --        -- lualine_a = {'buffers'},
    --        -- lualine_b = {},
    --        -- lualine_c = {},
    --        -- lualine_x = {},
    --        -- lualine_y = {},
    --        -- lualine_z = {},
    --    },
    extensions = {},
})
