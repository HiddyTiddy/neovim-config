--[[ local function t(str) ]]
--[[ 	return vim.api.nvim_replace_termcodes(str, true, true, true) ]]
--[[ end ]]
vim.g.mapleader = " "
vim.g.maplocalleader = " "
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("n", "<leader>pv", ":wincmd v<CR> :Ex <CR> :vertical resize 30<CR>", { noremap = true })

-- copy paste
map("n", "<leader>y", '"+y', { noremap = true })
map("v", "<leader>y", '"+y', { noremap = true })

map("n", "<leader>p", '"+p', { noremap = true })
map("v", "<leader>p", '"+p', { noremap = true })

map("n", "<leader>tn", ":tabnew<CR>:NvimTreeOpen<CR>", { noremap = false })
map("n", "<leader>mt", ":MinimapToggle<CR>", { noremap = true })
map("n", "<leader>.", "lua vim.lsp.buf.code_action()<cr>", { noremap = true })

-- map("n", "<leader>h", ":wincmd h<CR>", { noremap = false })
-- map("n", "<leader>j", ":wincmd j<CR>", { noremap = true })
-- map("n", "<leader>k", ":wincmd k<CR>", { noremap = true })
-- map("n", "<leader>l", ":wincmd l<CR>", { noremap = true })
-- map("n", "<leader>ll", ":wincmd l<CR>", { noremap = true })
map("n", "Y", "yg_", { noremap = true })
map("n", "gö", ":lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", { noremap = true })

-- map("n", "gx", ":!open <c-r><c-a><cr>", opts)
map("n", "gx", ":Open<cr>", opts)

-- move
map("n", "º", "<Esc>:m .+1<CR>==", opts)
map("n", "∆", "<Esc>:m .-2<CR>==", opts)
map("i", "º", "<Esc>:m .+1<CR>==a", opts)
map("i", "∆", "<Esc>:m .-2<CR>==a", opts)

-- indent
map("n", "<S-Tab>", "<<", opts)
map("i", "<S-Tab>", "<C-d>", opts)
map("n", "<Tab>", ">>", opts)
map("v", "<S-Tab>", "<", opts)
map("v", "<Tab>", ">", opts)

-- move
map("v", "º", ":m .+1<CR>==", opts)
map("v", "∆", ":m .-2<CR>==", opts)
map("v", "p", '"_dP', opts)

map("x", "K", ":move '<-2<CR>gv-gv", opts)
map("x", "J", ":move '>+1<CR>gv-gv", opts)
map("x", "º", ":move '>+1<CR>gv-gv", opts)
map("x", "∆", ":move '<-2<CR>gv-gv", opts)

map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", {silent = true})
map("n", "gD", "<cmd>lua vim.lsp.buf.definition()<cr>", {silent = true})

-- vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
-- vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge" })
