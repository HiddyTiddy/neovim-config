local function t(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

vim.g.mapleader = " "

vim.api.nvim_set_keymap("n", "<leader>pv", ":wincmd v<bar> :Ex <bar> :vertical resize 30<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>y", '"+y', { noremap = true })

vim.api.nvim_set_keymap("v", "<leader>y", '"+y', { noremap = true })

vim.api.nvim_set_keymap("n", "<leader>tn", ":tabnew<CR>:NvimTreeOpen<CR>", { noremap = false })
vim.api.nvim_set_keymap("n", "<leader>mt", ":MinimapToggle<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>rf", ":RustFmt<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<leader>h", ":wincmd h<CR>", { noremap = false })
vim.api.nvim_set_keymap("n", "<leader>j", ":wincmd j<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>k", ":wincmd k<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>l", ":wincmd l<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ll", ":wincmd l<CR>", { noremap = true })

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "º", "<Esc>:m .+1<CR>==", opts)
vim.api.nvim_set_keymap("n", "∆", "<Esc>:m .-2<CR>==", opts)
vim.api.nvim_set_keymap("i", "º", "<Esc>:m .+1<CR>==", opts)
vim.api.nvim_set_keymap("i", "∆", "<Esc>:m .-2<CR>==", opts)

vim.api.nvim_set_keymap("v", "º", ":m .+1<CR>==", opts)
vim.api.nvim_set_keymap("v", "∆", ":m .-2<CR>==", opts)
vim.api.nvim_set_keymap("v", "p", '"_dP', opts)

vim.api.nvim_set_keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
vim.api.nvim_set_keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
vim.api.nvim_set_keymap("x", "º", ":move '>+1<CR>gv-gv", opts)
vim.api.nvim_set_keymap("x", "∆", ":move '<-2<CR>gv-gv", opts)
