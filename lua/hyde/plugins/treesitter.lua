local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

require("treesitter-context").setup({ enable = true, max_lines = 1 })

configs.setup({
    ensure_installed = "all",
    sync_install = false,
    ignore_install = { "" },
    autopairs = {
        enable = true,
    },
    autotags = {
        enable = true
    },
    highlight = {
        enable = true,
        disable = { "org" },                           -- Remove this to use TS highlighter for some of the highlights (Experimental)
        additional_vim_regex_highlighting = { "org" }, -- Required since TS highlighter doesn't support all syntax features (conceal)
    },
    indent = { enable = true, disable = { "yaml" } },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    rainbow = {
        enable = true,
        extended_mode = true,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                -- You can optionally set descriptions to the mappings (used in the desc parameter of
                -- nvim_buf_set_keymap) which plugins like which-key display
                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                -- You can also use captures from other query groups like `locals.scm`
                ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                ["ib"] = { query = "@block.inner", desc = "inner block" },
                ["ab"] = { query = "@block.outer", desc = "outer block" },
                ["aS"] = { query = "@statement.outer", desc = "outer statement" },
            },
        },
    },
})
