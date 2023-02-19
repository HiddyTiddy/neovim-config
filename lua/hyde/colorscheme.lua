local cool_ones = { "nord", "catppuccin", "nordic" }

---@diagnostic disable-next-line: param-type-mismatch
math.randomseed(os.time(os.date("!*t")))

local colorscheme_i = math.random(#cool_ones)

vim.api.nvim_command("colorscheme " .. cool_ones[colorscheme_i])
-- vim.cmd [[ silent! colorscheme nord ]]
