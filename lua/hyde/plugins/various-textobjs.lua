local textobjs = require("various-textobjs")
local fn = vim.fn

local function setupKeymaps()
    local innerOuterMaps = {
        number = "n",
        value = "v",
        key = "k",
        subword = "S", -- lowercase taken for sentence textobj
    }
    local oneMaps = {
        nearEoL = "n",
        toNextClosingBracket = "%", -- since this is basically a more intuitive version of the standard "%" motion-as-textobj
        -- restOfParagraph = "r",
        restOfIndentation = "R",
        diagnostic = "!",
        column = "|",
        entireBuffer = "gG", -- G + gg
        url = "L", -- gu, gU, and U would conflict with gugu, gUgU, and gUU. u would conflict with gcu (undo comment)
    }
    local ftMaps = {
        {
            map = { jsRegex = "/" },
            fts = { "javascript", "typescript" },
        },
        {
            map = { mdlink = "l" },
            fts = { "markdown", "toml" },
        },
        {
            map = { mdFencedCodeBlock = "C" },
            fts = { "markdown" },
        },
        {
            map = { doubleSquareBrackets = "D" },
            fts = { "lua", "norg", "sh", "fish", "zsh", "bash", "markdown" },
        },
        {
            map = { cssSelector = "c" },
            fts = { "css", "scss" },
        },
        {
            map = { shellPipe = "P" },
            fts = { "sh", "bash", "zsh", "fish" },
        },
    }
    -----------------------------------------------------------------------------
    local keymap = vim.keymap.set
    for objName, map in pairs(innerOuterMaps) do
        local name = " " .. objName .. " textobj"
        keymap({ "o", "x" }, "a" .. map, function()
            textobjs[objName](false)
        end, { desc = "outer" .. name })
        keymap({ "o", "x" }, "i" .. map, function()
            textobjs[objName](true)
        end, { desc = "inner" .. name })
    end
    for objName, map in pairs(oneMaps) do
        keymap({ "o", "x" }, map, textobjs[objName], { desc = objName .. " textobj" })
    end
    -- stylua: ignore start
    keymap({ "o", "x" }, "ii", function() textobjs.indentation(true, true) end,
        { desc = "inner-inner indentation textobj" })
    keymap({ "o", "x" }, "ai", function() textobjs.indentation(false, true) end,
        { desc = "outer-inner indentation textobj" })
    keymap({ "o", "x" }, "iI", function() textobjs.indentation(true, true) end,
        { desc = "inner-inner indentation textobj" })
    keymap({ "o", "x" }, "aI", function() textobjs.indentation(false, false) end,
        { desc = "outer-outer indentation textobj" })

    vim.api.nvim_create_augroup("VariousTextobjs", {})
    for _, textobj in pairs(ftMaps) do
        vim.api.nvim_create_autocmd("FileType", {
            group = "VariousTextobjs",
            pattern = textobj.fts,
            callback = function()
                for objName, map in pairs(textobj.map) do
                    local name = " " .. objName .. " textobj"
                    keymap({ "o", "x" }, "a" .. map, function() textobjs[objName](false) end,
                        { desc = "outer" .. name, buffer = true })
                    keymap({ "o", "x" }, "i" .. map, function() textobjs[objName](true) end,
                        { desc = "inner" .. name, buffer = true })
                end
            end,
        })
    end
    -- stylua: ignore end
end

setupKeymaps()

vim.keymap.set("n", "gR", function()
    require("various-textobjs").jsRegex(false) -- set visual selection to outer regex
    vim.cmd.normal({ '"zy', bang = true }) -- retrieve regex with "z as intermediary
    local regex = vim.fn.getreg("z")

    local pattern = regex:match("/(.*)/")
    local flags = regex:match("/.*/(.*)")
    local replacement = fn.getline("."):match('replace ?%(/.*/.*, ?"(.-)"')

    -- https://github.com/firasdib/Regex101/wiki/FAQ#how-to-prefill-the-fields-on-the-interface-via-url
    local url = "https://regex101.com/?regex=" .. pattern .. "&flags=" .. flags
    if replacement then
        url = url .. "&subst=" .. replacement
    end

    local opener
    if vim.fn.has("macunix") then
        opener = "open"
    elseif vim.fn.has("unix") then
        opener = "xdg-open"
    elseif vim.fn.has("win64") or fn.has("win32") then
        opener = "start"
    end
    os.execute(opener .. "'" .. url .. "'")
end, { desc = "Open next js regex in regex101" })
