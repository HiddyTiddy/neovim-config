local M = {}

local icons = require("hyde.tools.icons")
local configs0 = require("hyde.lsp.configs")
local set_config = configs0.set_config
local configs = configs0.configs

M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = icons.error },
        { name = "DiagnosticSignWarn",  text = icons.warningTriangle },
        { name = "DiagnosticSignHint",  text = icons.info },
        { name = "DiagnosticSignInfo",  text = icons.questionCircle },
    }
    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        virtual_text = true,
        signs = {
            active = signs,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)
    vim.o.updatetime = 250

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    -- vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if not status_ok then
        return
    end

    M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

local function lsp_highlight_document(client)
    if client.server_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
          augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
        ]],
            false
        )
    end
end

local function lsp_keymaps(bufnr)
    local opts = { noremap = false, silent = false }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-?>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "gl",
        '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>',
        opts
    )
    vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({async = true})' ]])
end

M.go_org_imports = function(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for cid, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                vim.lsp.util.apply_workspace_edit(r.edit, enc)
            end
        end
    end
end

M.on_attach = function(client, bufnr)
    if client.name == "tsserver" then
        client.server_capabilities.document_formatting = false
    end

    if client.name == "rust-analyzer" then
        vim.cmd([[
            autocmd BufEnter,BufWinEnter *.rs :RustSetInlayHints
        ]])
    end

    if client.name == "gopls" then
        vim.cmd([[
            " autocmd BufWritePre *.go lua require("hyde.lsp.handlers").go_org_imports()
        ]])
    end

    local client_config = configs[client.name]
    set_config(client_config)

    if client.name == "ocamllsp" then
        require("which-key").register({
            l = {
                u = {
                    t = {
                        require("ocaml.actions").update_interface_type,
                        "Ocaml Update Type",
                    },
                },
            },
        }, {
            mode = "n",
            prefix = "<leader>",
            buf = bufnr,
            silent = true,  -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true,  -- use `nowait` when creating keymaps
        })
    end

    if client.resolved_capabilities and client.resolved_capabilities.code_lens then
        local codelens = vim.api.nvim_create_augroup("LSPCodeLens", { clear = true })
        vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "CursorHold" }, {
            group = codelens,
            callback = function()
                vim.lsp.codelens.refresh()
            end,
            buffer = bufnr,
        })
    end

    lsp_keymaps(bufnr)
    lsp_highlight_document(client)
end

M.capabilities = nil

return M
