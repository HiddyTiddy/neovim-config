local status_ok, Hydra = pcall(require, "hydra")
if not status_ok then
    return
end

local hint = [[
 Arrow^^^^^^   Select region with <C-v> 
 ^ ^ _K_ ^ ^   _f_: surround it with box
 _H_ ^ ^ _L_
 ^ ^ _J_ ^ ^                      _<Esc>_
]]

local before_virtual_edit = "none"

Hydra({
    name = "Draw Diagram",
    hint = hint,
    config = {
        color = "pink",
        invoke_on_body = true,
        hint = {
            border = "rounded",
        },
        on_enter = function()
            before_virtual_edit = vim.o.virtualedit
            vim.o.virtualedit = "all"
        end,
        on_exit = function()
            vim.o.virtualedit = before_virtual_edit
        end,
    },
    mode = "n",
    body = "<leader>n",
    heads = {
        { "H", "<C-v>h:VBox<CR>" },
        { "J", "<C-v>j:VBox<CR>" },
        { "K", "<C-v>k:VBox<CR>" },
        { "L", "<C-v>l:VBox<CR>" },
        { "f", ":VBox<CR>", { mode = "v" } },
        { "<Esc>", nil, { exit = true } },
    },
})
