local status_ok, nvim_lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

nvim_lspconfig.clangd.setup({})
