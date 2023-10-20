local options = {
    smartindent = true,
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    softtabstop = 4,
    relativenumber = true,
    mouse = "a",
    number = true,
    wildmenu = true,
    wildmode = "longest:full,full",
    incsearch = true,
    list = true,
    listchars = [[tab: ―→,trail:+,nbsp:·]],
    scrolloff = 10,
    sidescrolloff = 8,
    pumheight = 10,
    showmode = false,
    timeoutlen = 500, -- ms
    fileencoding = "utf-8",
    numberwidth = 2,
    guifont = "MesloLGS Nerd Font Mono:h18",
    wrap = false,
    termguicolors = true,
    cursorline = true,
    ignorecase = true,
    smartcase = true,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

local other_options = {
    grepprg = "rg -n $*",
    swapfile = false,
}

for k, v in pairs(other_options) do
    vim.o[k] = v
end
