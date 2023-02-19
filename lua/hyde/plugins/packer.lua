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
    autocmd BufWritePost packer.lua source <afile> | PackerSync
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
        use("wbthomason/packer.nvim") -- package manager

        use("ggandor/leap.nvim") -- jump around a bit better
        use("nvim-lua/popup.nvim")
        use("nvim-lua/plenary.nvim")
        use("norcalli/nvim_utils")
        use("windwp/nvim-autopairs")
        use({
            -- surround text
            "kylechui/nvim-surround",
            config = function()
                require("nvim-surround").setup({
                    -- Configuration here, or leave empty to use defaults
                })
            end,
        })
        use("numToStr/Comment.nvim")
        use("kyazdani42/nvim-web-devicons")
        use("kyazdani42/nvim-tree.lua")
        use("akinsho/bufferline.nvim") -- TODO customize
        use("Aasim-A/scrollEOF.nvim")

        --[[ use({ ]]
        --[[     "romgrk/barbar.nvim", ]]
        --[[     requires = { "kyazdani42/nvim-web-devicons" }, ]]
        --[[ }) ]]
        use("moll/vim-bbye")
        use("nvim-lualine/lualine.nvim") -- status bar
        use("ahmedkhalf/project.nvim")
        use("akinsho/toggleterm.nvim") -- persistent terminal?
        use("lewis6991/impatient.nvim") -- faster loading time
        use("lukas-reineke/indent-blankline.nvim") -- indentation
        use("goolord/alpha-nvim")
        use("folke/which-key.nvim") -- help popup
        use("antoinemadec/FixCursorHold.nvim")

        -- use("p00f/nvim-ts-rainbow")
        use("mrjones2014/nvim-ts-rainbow")

        -- ~~~~~~COLORSCHEMES~~~~~
        --
        -- [cool list here](https://github.com/rockerBOO/awesome-neovim#tree-sitter-supported-colorscheme)
        --
        --
        -- use("arcticicestudio/nord-vim")
        use("shaunsingh/nord.nvim")
        use("yunlingz/equinusocio-material.vim")
        use({
            "catppuccin/nvim",
            as = "catppuccin",
            config = function()
                require("catppuccin").setup({
                    flavour = "macchiato", -- mocha, macchiato, frappe, latte
                })
                --[[ vim.api.nvim_command "colorscheme catppuccin" ]]
            end,
        })
        use("Mofiqul/dracula.nvim")
        use("AlexvZyl/nordic.nvim")
        use("marko-cerovac/material.nvim")

        use("wfxr/minimap.vim")

        use({
            "rmagatti/auto-session",
            config = function()
                require("auto-session").setup({
                    log_level = "error",
                    auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
                })
            end,
        })
        use({
            "chrisgrieser/nvim-various-textobjs",
            config = function()
                require("various-textobjs").setup({ useDefaultKeymaps = true })
            end,
        })

        use({
            "folke/noice.nvim",
            event = "VimEnter",
            config = function()
                if vim.g.neovide == nil then
                    require("noice").setup({
                        messages = {
                            enabled = false,
                        },
                        notify = {
                            enabled = false,
                        },
                    })
                end
            end,
            requires = {
                "MunifTanjim/nui.nvim",
                -- "rcarriga/nvim-notify",
            },
        })

        -- rust
        -- use "rust-lang/rls"
        -- use "rust-lang/rust.vim"
        -- use "wagnerf42/vim-clippy"
        use("simrat39/rust-tools.nvim")
        -- use("kdarkhan/rust-tools.nvim")
        use({ "https://git.sr.ht/~p00f/godbolt.nvim", as = "godbolt.nvim" })
        use({
            "saecki/crates.nvim",
            tag = "v0.3.0",
            requires = { "nvim-lua/plenary.nvim" },
            config = function()
                require("crates").setup()
            end,
        })

        -- sql
        use("nanotee/sqls.nvim")

        use("puremourning/vimspector")

        -- cmp -- completion plugin
        use("hrsh7th/nvim-cmp")
        use("hrsh7th/cmp-buffer")
        use("hrsh7th/cmp-calc")
        use("hrsh7th/cmp-path")
        use("hrsh7th/cmp-cmdline")
        use("saadparwaiz1/cmp_luasnip")
        use("hrsh7th/cmp-nvim-lsp")

        -- snippets
        use("L3MON4D3/LuaSnip")
        use("rafamadriz/friendly-snippets") -- has rust!!!
        -- use({
        --     "tzachar/cmp-tabnine",
        --     run = "./install.sh",
        --     requires = "hrsh7th/nvim-cmp",
        --     config = function()
        --         require("cmp_tabnine.config"):setup({
        --             show_prediction_strength = true,
        --         })
        --     end,
        -- })

        -- LSP
        use("neovim/nvim-lspconfig")
        use("nvim-lua/lsp_extensions.nvim")
        use("williamboman/nvim-lsp-installer")
        use("tamago324/nlsp-settings.nvim")
        use("jose-elias-alvarez/null-ls.nvim")
        use("jose-elias-alvarez/nvim-lsp-ts-utils")
        -- use("asm_lsp")
        use("eliba2/vim-node-inspect")

        use("nvim-telescope/telescope.nvim")

        use({
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
        })
        use("nvim-treesitter/playground")
        use({
            "nvim-treesitter/nvim-treesitter-textobjects",
            after = "nvim-treesitter",
            requires = "nvim-treesitter/nvim-treesitter",
        })
        use("JoosepAlviste/nvim-ts-context-commentstring")
        use({
            "cshuaimin/ssr.nvim",
            module = "ssr",
            config = function()
                require("ssr").setup({
                    min_width = 50,
                    min_height = 5,
                    keymaps = {
                        close = "q",
                        next_match = "n",
                        prev_match = "N",
                        replace_all = "<leader><cr>",
                    },
                })
            end,
        })
        use({
            "mrcjkb/haskell-tools.nvim",
            requires = {
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope.nvim", -- optional
            },
            -- branch = "1.x.x", -- recommended
        })

        use("lewis6991/gitsigns.nvim")

        -- notes stuff
        -- kw: markdown
        use("sotte/presenting.vim")
        use({
            "jghauser/follow-md-links.nvim",
        })
        -- use("nullchilly/fsread.nvim")

        use("jbyuki/venn.nvim")
        use("anuvyklack/hydra.nvim")
        use({
            "phaazon/mind.nvim",
            branch = "v2.2",
            requires = { "nvim-lua/plenary.nvim" },
            config = function()
                require("mind").setup()
            end,
        })

        -- use("nvim-orgmode/orgmode")
        use({ "michaelb/sniprun", run = "bash ./install.sh" })

        use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })
        use("IndianBoy42/tree-sitter-just")
        use("NoahTheDuke/vim-just")

        -- latex
        use("lervag/vimtex")

        -- golang

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
