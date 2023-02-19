local opts = {
    tools = {
        autoSetHints = true,
        -- hover_with_actions = true,
        runnables = {
            use_telescope = true,
        },
        inlay_hints = {
            show_parameter_hints = false,
            only_current_line = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        on_attach = function(_, bufnr)
            vim.keymap.set("n", "<C-space>", require("rust-tools").hover_actions.hover_actions, { buffer = bufnr })
            vim.keymap.set("n", "<leader>º", function()
                require("rust-tools").move_item.move_item(true)
            end, { buffer = bufnr })
            vim.keymap.set("n", "<leader>∆", function()
                require("rust-tools").move_item.move_item(true)
            end, { buffer = bufnr })
            vim.keymap.set("n", "<leader>le", function()
                require("rust-tools.expand_macro").expand_macro()
            end, { buffer = bufnr })
            --[[ vim.keymap.set("n", "K", function() ??? end, { buffer = bufnr }) ]]
        end,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            -- https://rust-analyzer.github.io/manual.html#features
            -- https://rust-analyzer.github.io/manual.html
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy",
                },
                completion = {
                    callable = {
                        snippets = "fill_arguments",
                    },
                },
            },
        },
    },
}
require("rust-tools").setup(opts)
