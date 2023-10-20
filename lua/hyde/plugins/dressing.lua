local ok, dressing = pcall(require, "dressing")
if not ok then
    vim.notify("failed to load dressing", vim.log.levels.WARN)
    return
end

dressing.setup({
    select = {
        enabled = true,
        backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
        trim_prompt = true,
    },
})
