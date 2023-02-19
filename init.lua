require("hyde.options")
require("hyde.keymaps")

-- all the plugins
require("hyde.plugins")
require("hyde.lsp")

require("hyde.autocmd")
require("hyde.latex")
require("hyde.hydra")
require("hyde.colorscheme")
require("hyde.various.heckify")
if vim.g.neovide ~= nil then
    require("hyde.neovide")
end

require("hyde.migrate-move").setup({
    program = "migrate-move",
    up_template = "%d_%s.up.sql",
    down_template = "%d_%s.down.sql",
    dir_path = "migrations",
})

require("hyde.various.markdown").setup()
require("hyde.various.make")
require("hyde.various.open").setup()

require("hyde.rust-plugins")

-- https://github.com/LunarVim/Neovim-from-scratch/tree/master/lua/user

vim.cmd([[
syntax on
filetype indent on
]])

vim.cmd([[
autocmd Filetype tex setl updatetime=1
let g:livepreview_previewer = 'open -a Preview'

]])

vim.cmd([[
augroup vimtex_common
    autocmd!
    autocmd FileType tex lua require("hyde.latex").write_serverfile()
augroup END
]])

local time = os.date("*t")
STARTUPTIME = string.format("%d-%d-%d %d:%d:%d", time.year, time.month, time.day, time.hour, time.min, time.sec)
