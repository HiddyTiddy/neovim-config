local status_ok, nvim_lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("hyde.lsp.lsp-installer")
require("hyde.lsp.handlers").setup()
require("hyde.lsp.null-ls")

local rust_opts = {
	tools = {
		autoSetHints = true,
		hover_with_actions = true,
		inlay_hints = {
			show_parameter_hints = false,
			parameter_hints_prefix = "",
			other_hints_prefix = "",
		},
		server = {
			-- on_attach is a callback called when the language server attachs to the buffer
			-- on_attach = on_attach,
			settings = {
				-- to enable rust-analyzer settings visit:
				-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
				["rust-analyzer"] = {
					-- enable clippy on save
					checkOnSave = {
						command = "clippy",
					},
				},
			},
		},
	},
}

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- nvim_lspconfig.rust_analyzer.setup({ rust_opts })
-- Rust (our lord and savior)
require("rust-tools").setup({})

-- Python
nvim_lspconfig.pyright.setup({})

-- Java
nvim_lspconfig.groovyls.setup({
	cmd = { "java", "-jar", require("hyde.vars").groovyls_path },
})


-- C / C++
nvim_lspconfig.clangd.setup{}

-- node / deno
nvim_lspconfig.denols.setup{}
