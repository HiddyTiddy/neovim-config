local status_ok, nvim_lspconfig = pcall(require, "lspconfig")
local handlers = require("hyde.lsp.handlers")
if not status_ok then
    return
end

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    float = { border = "single" },
})

require("hyde.lsp.lsp-installer")
require("hyde.lsp.handlers").setup()
require("hyde.lsp.null-ls")

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- nvim_lspconfig.rust_analyzer.setup({ rust_opts })
-- Rust (our lord and savior)
-- require("rust-tools").setup({})
require("hyde.lsp.rust")

require("hyde.lsp.haskell")

-- Python
nvim_lspconfig.pyright.setup({})

-- Java
nvim_lspconfig.groovyls.setup({
    cmd = { "java", "-jar", require("hyde.vars").groovyls_path },
})

-- C / C++
require("hyde.lsp.clangd")

-- node / deno
require("hyde.lsp.typescript")

-- html
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

nvim_lspconfig.html.setup({
    capabilities = capabilities,
})

-- asm
nvim_lspconfig.asm_lsp.setup({
    cmd = { "asm-lsp" },
})

-- sql

--[[ nvim_lspconfig.sqlls.setup({ ]]
--[[ 	root_dir = nvim_lspconfig.util.root_pattern(".sqllsrc.json"), ]]
--[[ }) ]]
-- nvim_lspconfig.sqlls.setup({})

-- nvim_lspconfig.sqlls.setup({
--   cmd = { "/Users/hasenmafia/go/bin/sqls" },
--   on_attach = function(client, bufnr)
--     client.server_capabilities.document_formatting = false
--     client.server_capabilities.document_range_formatting = false
--     -- buf_map(bufnr, "n", "<leader>lf", "<cmd>%!pg_format -C -s 4 -<cr>", {})
--
--     buf_map(bufnr, "n", "<leader>lf", function()
--       local curpos = vim.fn.getcurpos()
--       vim.cmd([[%!pg_format -C -s 4 -<cr>]])
--       vim.fn.setpos(".", curpos)
--     end, {})
--
--     require("sqls").on_attach(client, bufnr)
--   end,
--   settings = {
--     sqls = {
--       connections = {
--         {
--           driver = "postgresql",
--           dataSourceName = "host=127.0.0.1 port=5432 user=postgres dbname=camels sslmode=disable password=yay-password",
--         },
--       },
--     },
--   },
-- })
--[[ nvim_lspconfig.sqls.setup({ ]]
--[[ }) ]]
-- Only define once
if not require("lspconfig.configs").hdl_checker then
    require("lspconfig.configs").hdl_checker = {
        default_config = {
            cmd = { "hdl_checker", "--lsp" },
            filetypes = { "vhdl", "verilog", "systemverilog" },
            root_dir = function(fname)
                -- will look for the .hdl_checker.config file in parent directory, a
                -- .git directory, or else use the current directory, in that order.
                local util = require("lspconfig").util
                return util.root_pattern(".hdl_checker.config")(fname)
                    or util.find_git_ancestor(fname)
                    or util.path.dirname(fname)
            end,
            settings = {},
        },
    }
end

nvim_lspconfig.hdl_checker.setup({})

nvim_lspconfig.cssls.setup({
    capabilities = capabilities,
})

nvim_lspconfig.jdtls.setup({})

nvim_lspconfig.lua_ls.setup(require("hyde.lsp.settings.lua_ls"))

nvim_lspconfig.texlab.setup({})
--[[ nvim_lspconfig.ltex.setup({}) ]]
nvim_lspconfig.gopls.setup({
    on_attach = function(client, bufnr)
        handlers.on_attach(client, bufnr)
    end,
})

nvim_lspconfig.jsonls.setup({})

nvim_lspconfig.graphql.setup({})
