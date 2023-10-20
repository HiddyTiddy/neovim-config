-- if true then return end
local status_ok, ufo = pcall(require, "ufo")
if not status_ok then
    return
end

vim.wo.foldcolumn = "1"
vim.wo.foldlevel = 99 -- feel free to decrease the value
vim.wo.foldenable = true

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

if
    pcall(ufo.setup, {
        provider_selector = function(_, _, _)
            -- function (bufnr, filetype, buftype)
            return { "treesitter", "indent" }
        end,
    })
then
else
    print("oops")
end
