local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local sqlfmt = {
    method = null_ls.methods.FORMATTING,
    filetypes = { "sql" },
    generator = null_ls.formatter({
        command = "python3.11",
        args = function()
            return { "/Users/hasenmafia/opt/hyde-source/sql-pretty.py", "-" }
        end,
        to_stdin = true,
    }),
}

local asmfmt = {
    method = null_ls.methods.FORMATTING,
    filetypes = { "asm" },
    generator = null_ls.formatter({
        command = "asmfmt",
        -- args = function()
        --     return { vim.fn.expand("%") }
        -- end,
        to_stdin = true,
    }),
}

local texfmt = {
    method = null_ls.methods.FORMATTING,
    filetypes = { "tex" },
    generator = null_ls.formatter({
        command = "latexindent",
        to_stdin = true,
    }),
}

null_ls.setup({
    --[[ debug = true, ]]
    sources = {
        -- formatting.prettier.with({ }),
        formatting.prettierd.with({
            filetypes = {
                "javascript",
                "javascriptreact",
                "typescript",
                "typescriptreact",
                "vue",
                "css",
                "scss",
                "less",
                "html",
                "json",
                "jsonc",
                "yaml",
                "graphql",
                "handlebars",
            },
        }),
        formatting.black.with({ extra_args = { "--fast" } }),
        formatting.stylua.with({ extra_args = { "--indent-type", "Spaces" } }),
        --diagnostics.eslint_d,
        --code_actions.eslint_d,
        formatting.markdown_toc,
        formatting.mdformat,
        -- diagnostics.flake8
        sqlfmt,
        texfmt,
        asmfmt,
    },
})
