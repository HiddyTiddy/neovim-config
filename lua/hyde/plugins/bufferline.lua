--[[ local status_ok, bufferline = pcall(require, "bufferline") ]]
--[[ if not status_ok then ]]
--[[     print("error with bufferline") ]]
--[[     return ]]
--[[ end ]]
--[[ bufferline.setup({ ]]
--[[     clickable = true, ]]
--[[     animation = true, ]]
--[[]]
--[[     options = { ]]
--[[         numbers = "buffer_id", ]]
--[[         right_mouse_command = "Bdelete!", ]]
--[[         diagnostics = "nvim_lsp", ]]
--[[     }, ]]
--[[ }) ]]
--[[ bufferline.setup() ]]
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false }
vim.cmd("set mousemoveevent")

for i = 1, 9 do
    map("n", "<leader>" .. i, "<cmd>lua require('bufferline').go_to_buffer(" .. i .. ")<cr>", opts)
end
map("n", "<leader>0", "<cmd>lua require('bufferline').go_to_buffer(-1)<cr>", opts)

local groups = {
    options = {
        toggle_hidden_on_enter = true,
    },
    items = {
        {
            name = "Docs",
            highlight = { undercurl = false, sp = "green" },
            auto_close = false,
            custom_filter = function(buf_number)
                local ft = vim.bo[buf_number].filetype
                return ft == "markdown" or ft == "md" or ft == "txt"
            end,
            --[[ separator = { ]]
            --[[     style = require("bufferline.groups").separator.tab, ]]
            --[[ }, ]]
        },
    },
}

require("bufferline").setup({
    options = {
                -- NVIm built-in LSP
        diagnostics = "nvim_lsp",
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                separator = true,
            },
        },
        indicator = {
            icon = "▎",
            style = "icon",
        },
        diagnostics_indicator = function(
            count,
            level -- , diagnostics_dict, context
        )
            local icon = level:match("error") and "" or ""
            return " (" .. icon .. count .. ")"
        end,
        hover = {
            enabled = true,
            delay = 20,
            reveal = { "close" },
        },
        separator_style = "thick",
        groups = groups,
    },
})
-- TODO customize bufferline or use tabline
--[[ bufferline.setup() ]]
return

--[[ require("bufferline").setup({ ]]
--[[     options = { ]]
--[[         mode = "buffers", -- set to "tabs" to only show tabpages instead ]]
--[[         numbers = "buffer_id", ]]
--[[         close_command = "bdelete! %d", ]]
--[[         right_mouse_command = "bdelete! %d", ]]
--[[         left_mouse_command = function () ]]
--[[             print("hi") ]]
--[[             vim.cmd("buffer %d") ]]
--[[         end, ]]
--[[         middle_mouse_command = nil, ]]
--[[         indicator = { ]]
--[[             icon = "▎", ]]
--[[             style = "icon", ]]
--[[         }, ]]
--[[         buffer_close_icon = "󰅖", ]]
--[[         modified_icon = "●", ]]
--[[         close_icon = "", ]]
--[[         left_trunc_marker = "", ]]
--[[         right_trunc_marker = "", ]]
--[[         --- name_formatter can be used to change the buffer's label in the bufferline. ]]
--[[         --- Please note some names can/will break the ]]
--[[         --- bufferline so use this at your discretion knowing that it has ]]
--[[         --- some limitations that will *NOT* be fixed. ]]
--[[         name_formatter = function(buf) -- buf contains: ]]
--[[             -- name                | str        | the basename of the active file ]]
--[[             -- path                | str        | the full path of the active file ]]
--[[             -- bufnr (buffer only) | int        | the number of the active buffer ]]
--[[             -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab ]]
--[[             -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)` ]]
--[[         end, ]]
--[[         max_name_length = 18, ]]
--[[         max_prefix_length = 15, ]]
--[[         truncate_names = true, ]]
--[[         tab_size = 18, ]]
--[[         diagnostics = "nvim_lsp", ]]
--[[         diagnostics_update_in_insert = false, ]]
--[[         -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting ]]
--[[         diagnostics_indicator = function(count, level, diagnostics_dict, context) ]]
--[[             return "(" .. count .. ")" ]]
--[[         end, ]]
--[[         -- NOTE: this will be called a lot so don't do any heavy processing here ]]
--[[         custom_filter = function(buf_number, buf_numbers) ]]
--[[             -- filter out filetypes you don't want to see ]]
--[[             if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then ]]
--[[                 return true ]]
--[[             end ]]
--[[             -- filter out by buffer name ]]
--[[             if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then ]]
--[[                 return true ]]
--[[             end ]]
--[[             -- filter out based on arbitrary rules ]]
--[[             -- e.g. filter out vim wiki buffer from tabline in your work repo ]]
--[[             if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then ]]
--[[                 return true ]]
--[[             end ]]
--[[             -- filter out by it's index number in list (don't show first buffer) ]]
--[[             if buf_numbers[1] ~= buf_number then ]]
--[[                 return true ]]
--[[             end ]]
--[[         end, ]]
--[[         offsets = { ]]
--[[             { ]]
--[[                 filetype = "NvimTree", ]]
--[[                 text = "File Explorer", ]]
--[[                 text_align = "left", ]]
--[[                 separator = true, ]]
--[[             }, ]]
--[[         }, ]]
--[[         color_icons = true , -- whether or not to add the filetype icon highlights ]]
--[[         show_buffer_icons = true, -- disable filetype icons for buffers ]]
--[[         show_buffer_close_icons = true , ]]
--[[         show_buffer_default_icon = true , -- whether or not an unrecognised filetype should show a default icon ]]
--[[         show_close_icon = true , ]]
--[[         show_tab_indicators = true , ]]
--[[         show_duplicate_prefix = true , -- whether to show duplicate buffer prefix ]]
--[[         persist_buffer_sort = true, -- whether or not custom sorted buffers should persist ]]
--[[         -- can also be a table containing 2 custom separators ]]
--[[         -- [focused and unfocused]. eg: { '|', '|' } ]]
--[[         separator_style = "slant",  ]]
--[[         enforce_regular_tabs = false, ]]
--[[         always_show_bufferline = true, ]]
--[[         hover = { ]]
--[[             enabled = true, ]]
--[[             delay = 200, ]]
--[[             reveal = { "close" }, ]]
--[[         }, ]]
--[[         sort_by = "insert_after_current", ]]
--[[     }, ]]
--[[ }) ]]
-- bufferline.setup {
--       options = {
--          numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
--          close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
--          right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
--          left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
--          middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
--          -- NOTE: this plugin is designed with this icon in mind,
--          -- and so changing this is NOT recommended, this is intended
--          -- as an escape hatch for people who cannot bear it for whatever reason
--          indicator_icon = "▎",
--          buffer_close_icon = "󰅖",
--          -- buffer_close_icon = '',
--          modified_icon = "●",
--          close_icon = "",
--          -- close_icon = '󰅙',
--          left_trunc_marker = "",
--          right_trunc_marker = "",
--         --- name_formatter can be used to change the buffer's label in the bufferline.
--         --- Please note some names can/will break the
--         --- bufferline so use this at your discretion knowing that it has
--         --- some limitations that will *NOT* be fixed.
--         -- name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
--         --   -- remove extension from markdown files for example
--         --   if buf.name:match('%.md') then
--         --     return vim.fn.fnamemodify(buf.name, ':t:r')
--         --   end
--         -- end,
--         max_name_length = 30,
--         max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
--         tab_size = 21,
--         diagnostics = false, -- | "nvim_lsp" | "coc",
--         diagnostics_update_in_insert = false,
--         -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
--         --   return "("..count..")"
--         -- end,
--         -- NOTE: this will be called a lot so don't do any heavy processing here
--         -- custom_filter = function(buf_number)
--         --   -- filter out filetypes you don't want to see
--         --   if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
--         --     return true
--         --   end
--         --   -- filter out by buffer name
--         --   if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
--         --     return true
--         --   end
--         --   -- filter out based on arbitrary rules
--         --   -- e.g. filter out vim wiki buffer from tabline in your work repo
--         --   if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
--         --     return true
--         --   end
--         -- end,
--         offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
--         show_buffer_icons = true,
--         show_buffer_close_icons = true,
--         show_close_icon = true,
--         show_tab_indicators = true,
--         persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
--         -- can also be a table containing 2 custom separators
--         -- [focused and unfocused]. eg: { '|', '|' }
--         separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
--         enforce_regular_tabs = true,
--         always_show_bufferline = true,
--         -- sort_by = 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
--         --   -- add custom logic
--         --   return buffer_a.modified > buffer_b.modified
--         -- end
--     },
--     highlights = {
--         fill = {
--             guifg = { attribute = "fg", highlight = "#ff0000" },
--             guibg = { attribute = "bg", highlight = "TabLine" },
--         },
--         background = {
--             guifg = { attribute = "fg", highlight = "TabLine" },
--             guibg = { attribute = "bg", highlight = "TabLine" },
--         },
--
--         -- buffer_selected = {
--         --   guifg = {attribute='fg',highlight='#ff0000'},
--         --   guibg = {attribute='bg',highlight='#0000ff'},
--         --   gui = 'none'
--         --   },
--         buffer_visible = {
--             guifg = { attribute = "fg", highlight = "TabLine" },
--             guibg = { attribute = "bg", highlight = "TabLine" },
--         },
--
--         close_button = {
--             guifg = { attribute = "fg", highlight = "TabLine" },
--             guibg = { attribute = "bg", highlight = "TabLine" },
--         },
--         close_button_visible = {
--             guifg = { attribute = "fg", highlight = "TabLine" },
--             guibg = { attribute = "bg", highlight = "TabLine" },
--         },
--         -- close_button_selected = {
--         --   guifg = {attribute='fg',highlight='TabLineSel'},
--         --   guibg ={attribute='bg',highlight='TabLineSel'}
--         --   },
--
--         tab_selected = {
--             guifg = { attribute = "fg", highlight = "Normal" },
--             guibg = { attribute = "bg", highlight = "Normal" },
--         },
--         tab = {
--             guifg = { attribute = "fg", highlight = "TabLine" },
--             guibg = { attribute = "bg", highlight = "TabLine" },
--         },
--         tab_close = {
--             -- guifg = {attribute='fg',highlight='LspDiagnosticsDefaultError'},
--             guifg = { attribute = "fg", highlight = "TabLineSel" },
--             guibg = { attribute = "bg", highlight = "Normal" },
--         },
--
--         duplicate_selected = {
--             guifg = { attribute = "fg", highlight = "TabLineSel" },
--             guibg = { attribute = "bg", highlight = "TabLineSel" },
--             gui = "italic",
--         },
--         duplicate_visible = {
--             guifg = { attribute = "fg", highlight = "TabLine" },
--             guibg = { attribute = "bg", highlight = "TabLine" },
--             gui = "italic",
--         },
--         duplicate = {
--             guifg = { attribute = "fg", highlight = "TabLine" },
--             guibg = { attribute = "bg", highlight = "TabLine" },
--             gui = "italic",
--         },
--
--         modified = {
--             guifg = { attribute = "fg", highlight = "TabLine" },
--             guibg = { attribute = "bg", highlight = "TabLine" },
--         },
--         modified_selected = {
--             guifg = { attribute = "fg", highlight = "Normal" },
--             guibg = { attribute = "bg", highlight = "Normal" },
--         },
--         modified_visible = {
--             guifg = { attribute = "fg", highlight = "TabLine" },
--             guibg = { attribute = "bg", highlight = "TabLine" },
--         },
--
--         separator = {
--             guifg = { attribute = "bg", highlight = "TabLine" },
--             guibg = { attribute = "bg", highlight = "TabLine" },
--         },
--         separator_selected = {
--             guifg = { attribute = "bg", highlight = "Normal" },
--             guibg = { attribute = "bg", highlight = "Normal" },
--         },
--         -- separator_visible = {
--         --   guifg = {attribute='bg',highlight='TabLine'},
--         --   guibg = {attribute='bg',highlight='TabLine'}
--         --   },
--         indicator_selected = {
--             guifg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
--             guibg = { attribute = "bg", highlight = "Normal" },
--         },
--     },
-- }
