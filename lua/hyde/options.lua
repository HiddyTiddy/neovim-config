local options = {
    smartindent = true,
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    softtabstop = 4,
    relativenumber = true,
    mouse = 'a',
    number = true,
    wildmenu = true,
    wildmode = 'longest:full,full',
    incsearch = true,
    list = true,
    listchars = [[tab:  ,trail:+]],
    scrolloff=6,
    sidescrolloff=8,
    pumheight = 10,
    showmode = false,
    timeoutlen = 500, -- ms
    fileencoding = "utf-8",
    numberwidth = 2,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end
