vim.g.neovide_input_use_logo = true

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local modes = { "n", "v", "x", "s", "t", "i", "c" }

vim.g.neovide_remember_window_size = true
vim.g.neovide_confirm_quit = true
vim.g.neovide_cursor_vfx_mode = "pixiedust"

for _, mode in pairs(modes) do
    map(mode, "<D-s>", "<cmd>w<cr>", opts)
    for i = 1, 9 do
        map(mode, "<D-" .. i .. ">", "<cmd>lua require('bufferline').go_to_buffer(" .. i .. ")<cr>", opts)
    end

    map(mode, "<D-0>", "<cmd>lua require('bufferline').go_to_buffer(-1)<cr>", opts)
    map(mode, "<D-,>", "<cmd>tabnew | e ~/.config/nvim/init.lua <CR>", opts)

    map(mode, "<D-t>", "<cmd>enew<cr>", opts)
    map(mode, "<D-l>", "<cmd>wincmd v|wincmd l|enew<cr>", opts)
    map(mode, "<D-h>", "<cmd>wincmd v|wincmd h|enew<cr>", opts)
    map(mode, "<D-k>", "<cmd>split|wincmd k|enew<cr>", opts)
    map(mode, "<D-j>", "<cmd>split|wincmd j|enew<cr>", opts)
    map(mode, "<D-w>", "<cmd>Bdelete<cr>", opts)
    map(mode, "<D-Enter>", "<cmd>lua vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen<cr>", opts)
end

-- copy/paste

map("n", "<D-c>", '"+y', opts)
map("n", "<D-v>", '"+p', opts)
map("v", "<D-c>", '"+y', opts)
map("v", "<D-v>", '"+p', opts)

map("i", "<D-c>", '<esc>"+y', opts)
map("i", "<D-v>", '<esc>"+p', opts)
map("t", "<D-c>", '<esc>"+y', opts)
map("t", "<D-v>", '<esc>"+p', opts)

map("c", "<D-v>", "<C-R>+", { noremap = true })

map("n", "<D-f>", "/", opts)
