local fn = vim.fn
local loop = vim.loop

local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
    print("Installing Lazy. Close and reopen Neovim..")
end

vim.opt.rtp:prepend(lazypath)

-- vim.cmd([[
--   augroup lazy_user_config
--     autocmd!
--     autocmd BufWritePost lazy.lua source <afile> |
--   augroup end
-- ]])

local lazy_ok, lazy = pcall(require, "lazy")
if not lazy_ok then
    return
end


local plugins = require("hyde.plugins.aa-plugins")

local opts = {}

lazy.setup(plugins, opts)
