local ht = require("haskell-tools")
local def_opts = { noremap = true, silent = true }
vim.g.haskell_tools = {
    hls = {
        on_attach = function(_, bufnr)
            local opts = vim.tbl_extend("keep", def_opts, { buffer = bufnr })
            -- haskell-language-server relies heavily on codeLenses,
            -- so auto-refresh (see advanced configuration) is enabled by default
            vim.keymap.set("n", "<space>lca", vim.lsp.codelens.run, opts)
            vim.keymap.set("n", "<space>lH", ht.hoogle.hoogle_signature, opts)

            vim.keymap.set("n", "<space>le", ht.lsp.buf_eval_all, opts)
        end,
    },
}

-- Suggested keymaps that do not depend on haskell-language-server
-- Toggle a GHCi repl for the current package
vim.keymap.set("n", "<leader>rr", ht.repl.toggle, def_opts)
-- Toggle a GHCi repl for the current buffer
vim.keymap.set("n", "<leader>rf", function()
    ht.repl.load_file(vim.api.nvim_buf_get_name(0))
end, def_opts)
vim.keymap.set("n", "<leader>rq", ht.repl.quit, def_opts)
