local fn = vim.fn

-- install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	use("wbthomason/packer.nvim")

	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim")
	use("windwp/nvim-autopairs")
	use("numToStr/Comment.nvim")
	use("kyazdani42/nvim-web-devicons")
	use("kyazdani42/nvim-tree.lua")
	-- use "akinsho/bufferline.nvim" -- TODO customize
	use("moll/vim-bbye")
	use("nvim-lualine/lualine.nvim") -- status bar
	use("ahmedkhalf/project.nvim")
	use("akinsho/toggleterm.nvim") -- persistent terminal?
	use("lewis6991/impatient.nvim") -- faster loading time
	use("lukas-reineke/indent-blankline.nvim") -- indentation
	use("goolord/alpha-nvim")
	use("folke/which-key.nvim") -- help popup
	use("antoinemadec/FixCursorHold.nvim")

	use("arcticicestudio/nord-vim")
	use("wfxr/minimap.vim")

	-- rust
	-- use "rust-lang/rls"
	-- use "rust-lang/rust.vim"
	-- use "wagnerf42/vim-clippy"
	use("simrat39/rust-tools.nvim")

	-- cmp -- completion plugin
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("saadparwaiz1/cmp_luasnip")
	use("hrsh7th/cmp-nvim-lsp")

	-- snippets
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets") -- has rust!!!

	-- LSP
	use("neovim/nvim-lspconfig")
	use("nvim-lua/lsp_extensions.nvim")
	use("williamboman/nvim-lsp-installer")
	use("tamago324/nlsp-settings.nvim")
	use("jose-elias-alvarez/null-ls.nvim")

	use("nvim-telescope/telescope.nvim")

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("JoosepAlviste/nvim-ts-context-commentstring")

	use("lewis6991/gitsigns.nvim")

	-- notes stuff
	use("sotte/presenting.vim")
	use( "nvim-orgmode/orgmode")

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)

-- vim.cmd([[
-- call plug#begin('~/.config/nvim/plugged')
-- Plug 'neoclide/coc.nvim', {'branch': 'release'}
-- " theme
-- Plug 'arcticicestudio/nord-vim'
--
-- " rust
-- Plug 'rust-lang/rls'
-- Plug 'rust-lang/rust.vim'
-- Plug 'wagnerf42/vim-clippy'
--
-- " latex
-- Plug 'lervag/vimtex'
-- Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
--
-- Plug 'mhinz/vim-startify'
--
-- call plug#end()
-- ]])
--
