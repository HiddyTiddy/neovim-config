local status_ok, neodev = pcall(require, "neodev")
if not status_ok then
    print("failed to require neodev")
    return
end
local nlspsettings
status_ok, nlspsettings = pcall(require, "nlspsettings")
if not status_ok then
    print("failed to require nlspsettings")
    return
end
-- local lsp_installer
-- status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
-- if not status_ok then
--     print("failed to require lsp_installer")
--     return
-- end

neodev.setup({
    -- add any options here, or leave empty to use the default settings
})

local nvim_lspconfig
status_ok, nvim_lspconfig = pcall(require, "lspconfig")
local handlers = require("hyde.lsp.handlers")
if not status_ok then
    return
end

nlspsettings.setup({
    config_home = vim.fn.stdpath("config") .. "/nlsp-settings",
    local_settings_dir = ".nlsp-settings",
    local_settings_root_markers_fallback = { ".git" },
    append_default_schemas = true,
    loader = "json",
    ignored_servers = {},
    open_strictly = false,
    nvim_notify = { enable = false, timeout = 5000 },
})

local global_capabilities = vim.lsp.protocol.make_client_capabilities()
global_capabilities.textDocument.completion.completionItem.snippetSupport = true

nvim_lspconfig.util.default_config = vim.tbl_extend("force", nvim_lspconfig.util.default_config, {
    capabilities = global_capabilities,
})

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    float = { border = "single" },
})

require("hyde.lsp.lsp-installer")
handlers.setup()
require("hyde.lsp.null-ls")

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- nvim_lspconfig.rust_analyzer.setup({ rust_opts })
-- Rust (our lord and savior)
-- require("rust-tools").setup({})
require("hyde.lsp.rust")

require("hyde.lsp.haskell")

-- Python
-- nvim_lspconfig.pyright.setup({})
nvim_lspconfig.anakin_language_server.setup({
    anakinls = {
        mypy_enabled = true,
    },
})

-- Java
nvim_lspconfig.groovyls.setup({
    cmd = { "java", "-jar", require("hyde.vars").groovyls_path },
})

-- C / C++
require("hyde.lsp.clangd")

-- node / deno
-- require("hyde.lsp.typescript")

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

-- nvim_lspconfig.sqls.setup({
--     on_attach = function(client, bufnr)
--         -- client.server_capabilities.document_formatting = false
--         -- client.server_capabilities.document_range_formatting = false
--         client.server_capabilities.documentFormattingProvider = false
--         client.server_capabilities.documentRangeFormattingProvider = false
--         require("sqls").on_attach(client, bufnr)
--     end,
--     cmd = { "/Users/hasenmafia/opt/sqls/sqls" },
--     settings = {
--         sqls = {
--             connections = {
--                 {
--                     driver = "postgresql",
--                     dataSourceName = "postgres://postgres@127.0.0.1:5432/employee?sslmode=disable",
--                 },
--                 {
--                     driver = "postgresql",
--                     dataSourceName = "postgres://postgres@127.0.0.1:5432/zvv?sslmode=disable",
--                 },
--
--                 {
--                     driver = "postgresql",
--                     dataSourceName = "postgres://postgres@127.0.0.1:5432/tpch?sslmode=disable",
--                 },
--             },
--         },
--     },
-- })

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

-- list of enabled servers without custom config
-- TODO: make custom configs have a place to live here
local enabled_servers = {
    "hdl_checker",
    "jdtls",
    "texlab",
    "jsonls",
    "taplo",
    "zls",
    "emmet_ls",
    "svelte",
    "tailwindcss",
    "bashls",
    "julials"
}

require("hyde.lsp.ocaml")

nvim_lspconfig.cssls.setup({
    capabilities = capabilities,
})

nvim_lspconfig.lua_ls.setup(require("hyde.lsp.settings.lua_ls"))

--[[ nvim_lspconfig.ltex.setup({}) ]]
nvim_lspconfig.gopls.setup({
    on_attach = function(client, bufnr)
        handlers.on_attach(client, bufnr)
    end,
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true
            }
        }
    },
})

nvim_lspconfig.jsonls.setup(require("hyde.lsp.settings.jsonls"))

for _, server in ipairs(enabled_servers) do
    nvim_lspconfig[server].setup({ on_attach = handlers.on_attach })
end
