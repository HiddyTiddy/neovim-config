local status_ok, godbolt = pcall(require, "godbolt.nvim")
if not status_ok then
    print("godbolt.nvim not installed")
    return
end

godbolt.setup({
    languages = {
        cpp = { compiler = "g122", options = {} },
        c = { compiler = "cg122", options = {} },
        rust = { compiler = "r1660", options = {} },
        -- any_additional_filetype = { compiler = ..., options = ... },
    },
    quickfix = {
        enable = true, -- whether to populate the quickfix list in case of errors
        auto_open = true, -- whether to open the quickfix list in case of errors
    },
    url = "https://godbolt.org", -- can be changed to a different godbolt instance
})
