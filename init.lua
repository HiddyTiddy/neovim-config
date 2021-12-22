require("hyde.plugins")
require("hyde.options")
require("hyde.colorscheme")
require("hyde.cmp")
require("hyde.treesitter")
require("hyde.whichkey")
require("hyde.nvim-tree")
require("hyde.keymaps")
require("hyde.toggleterm")
require("hyde.telescope")
require("hyde.alpha")
require("hyde.indentline")
require("hyde.lualine")
require("hyde.bufferline")
require("hyde.comment")
require("hyde.project")
require("hyde.lsp") -- i forgor
require("hyde.impatient")
require("hyde.gitsigns")
require("hyde.autocmd")
require("hyde.autopairs")


-- https://github.com/LunarVim/Neovim-from-scratch/tree/master/lua/user

vim.cmd(
[[
syntax on
filetype indent on
]])

vim.cmd([[
autocmd Filetype tex setl updatetime=1
let g:livepreview_previewer = 'open -a Preview'

]])

