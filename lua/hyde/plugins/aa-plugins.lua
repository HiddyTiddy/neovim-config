local colorscheme = function(repo, name, config)
    local out = { repo, priority = 1000 }

    if name ~= nil then
        out["name"] = name
    end

    if config ~= nil then
        out["config"] = config
    end
    return out
end

return {
    "ggandor/leap.nvim", -- jump around a bit better
    {
        "cbochs/portal.nvim",
        -- Optional dependencies
        dependencies = {
            "cbochs/grapple.nvim",
            "ThePrimeagen/harpoon",
        },
    },

    -- ui
    "nvim-lua/popup.nvim",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "norcalli/nvim_utils",
    "windwp/nvim-autopairs",
    {
        -- surround text
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup(
            -- Configuration here, or leave empty to use defaults
            )
        end,
    },
    "numToStr/Comment.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-tree/nvim-tree.lua",
    "akinsho/bufferline.nvim",
    "Aasim-A/scrollEOF.nvim",
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        opts = {
            -- configurations go here
        },
    },

    "moll/vim-bbye",
    "nvim-lualine/lualine.nvim", -- status bar
    "ahmedkhalf/project.nvim",
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("hyde.plugins.toggleterm")
        end,
        lazy = true,
        cmd = "ToggleTerm",
    },
    "lewis6991/impatient.nvim",            -- faster loading time
    "lukas-reineke/indent-blankline.nvim", -- indentation
    {
        "goolord/alpha-nvim",
        lazy = true,
        cmd = "Alpha",
        config = function()
            require("hyde.plugins.alpha")
        end,
    },
    "folke/which-key.nvim", -- help popup
    "antoinemadec/FixCursorHold.nvim",

    -- "p00f/nvim-ts-rainbow",
    -- "mrjones2014/nvim-ts-rainbow",
    -- { url = "git@gitlab.com:HiPhish/nvim-ts-rainbow2.git" },
    { url = "https://gitlab.com/HiPhish/nvim-ts-rainbow2" },

    -- ~~~~~~COLORSCHEMES~~~~~
    --
    -- [cool list here](https://github.com/rockerBOO/awesome-neovim#tree-sitter-supported-colorscheme)
    -- https://github.com/rockerBOO/awesome-neovim#tree-sitter-supported-colorscheme
    --
    -- "arcticicestudio/nord-vim",
    colorscheme("shaunsingh/nord.nvim"),
    colorscheme("yunlingz/equinusocio-material.vim"),
    colorscheme("catppuccin/nvim", "catppuccin", function()
        require("catppuccin").setup({
            flavour = "macchiato", -- mocha, macchiato, frappe, latte
        })
        --[[ vim.api.nvim_command "colorscheme catppuccin" ]]
    end),
    colorscheme("Mofiqul/dracula.nvim"),
    colorscheme("AlexvZyl/nordic.nvim"),
    colorscheme("marko-cerovac/material.nvim"),
    colorscheme("Mofiqul/vscode.nvim", nil, function()
        local c = require("vscode.colors").get_colors()
        require("vscode").setup({
            -- Enable transparent background
            -- transparent = true,
            -- Enable italic comment
            italic_comments = true,
            -- Disable nvim-tree background color
            -- disable_nvimtree_bg = true,
            -- Override colors (see ./lua/vscode/colors.lua)
            color_overrides = {
                vscLineNumber = "#FFFFFF",
            },
            -- Override highlight groups (see ./lua/vscode/theme.lua)
            group_overrides = {
                -- this supports the same val table as vim.api.nvim_set_hl
                -- use colors from this colorscheme by requiring vscode.colors!
                Cursor = { fg = c.vscDarkBlue, bold = true },
            },
        })
    end),

    "wfxr/minimap.vim",

    {
        "rmagatti/auto-session",
        config = function()
            require("auto-session").setup({
                log_level = "error",
                auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
            })
        end,
    },
    {
        "dstein64/vim-startuptime",
        lazy = true,
        cmd = "StartupTime",
    },

    -- {
    --     "folke/edgy.nvim",
    --     event = "VeryLazy",
    --     opts = {
    --         right = {
    --             ft = "toggleterm",
    --             size = {height = 0.4},
    --             -- exclude floating windows
    --             filter = function(buf, win)
    --               return vim.api.nvim_win_get_config(win).relative == ""
    --             end,
    --         }
    --     }
    -- },

    {
        "chrisgrieser/nvim-various-textobjs",
        config = function()
            -- require("various-textobjs").setup({ useDefaultKeymaps = true })
            require("hyde.plugins.various-textobjs")
        end,
    },
    {
        "chrisgrieser/nvim-spider",
        lazy = true,
        config = function() end,
    },

    {
        "axieax/urlview.nvim",
        config = function()
            local urlview = require("urlview")
            urlview.setup({ default_picker = "telescope" })
            vim.api.nvim_create_user_command("UrlView", function(args)
                if args.args ~= nil then
                    urlview.search(args.args, {})
                else
                    urlview.search("buffer", {})
                end
            end, { nargs = "?" })
        end,
    },

    {
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
        dependencies = {
            "MunifTanjim/nui.nvim",
            -- "rcarriga/nvim-notify",
        },
    },

    -- rust
    -- use "rust-lang/rls"
    -- use "rust-lang/rust.vim"
    -- use "wagnerf42/vim-clippy"
    -- "simrat39/rust-tools.nvim",
    -- "kdarkhan/rust-tools.nvim",
    "arindas/rust-tools.nvim",
    { "https://git.sr.ht/~p00f/godbolt.nvim",             name = "godbolt.nvim" },
    {
        "saecki/crates.nvim",
        tag = "v0.3.0",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("crates").setup()
        end,
        lazy = true,
    },
    "pest-parser/pest.vim",

    -- sql
    { "nanotee/sqls.nvim",    lazy = true, ft = "sql" },

    {
        "mfussenegger/nvim-dap",
        config = function()
            require("hyde.plugins.debugger")
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            require("dapui").setup({})
        end,
    },
    -- "theHamsta/nvim-dap-virtual-text",
    -- "nvim-telescope/telescope-dap.nvim",
    -- {
    --     "puremourning/vimspector",
    --     lazy = true,
    --     config = function()
    --         require("hyde.plugins.vimspector")
    --     end,
    -- },

    -- web stuff
    {
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    },

    -- cmp -- completion plugin
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "davidsierradz/cmp-conventionalcommits",
    "f3fora/cmp-spell",

    -- snippets
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets", -- has rust!!!
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
    "neovim/nvim-lspconfig",
    "nvim-lua/lsp_extensions.nvim",
    "williamboman/nvim-lsp-installer",
    "tamago324/nlsp-settings.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    -- "asm_lsp",
    "eliba2/vim-node-inspect",
    "rhysd/vim-llvm",
    "folke/neodev.nvim",
    {
        "pmizio/typescript-tools.nvim",
        requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {
            on_attach = require("hyde.lsp.handlers").on_attach,
            settings = {
                expose_as_code_action = "all",
                complete_function_calls = false,
            },
        },
    },

    "mlr-msft/vim-loves-dafny",

    "nvim-telescope/telescope.nvim",

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    "nvim-treesitter/playground",
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        after = "nvim-treesitter",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    "JoosepAlviste/nvim-ts-context-commentstring",
    {
        "cshuaimin/ssr.nvim",
        -- module = "ssr",
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
        lazy = true,
    },
    {
        "wansmer/treesj",
        keys = {
            "<leader>um",
            "<leader>uj",
            "<leader>us",
            dependencies = { "nvim-treesitter/nvim-treesitter" },
            config = function()
                require("treesj").setup({ use_default_keymaps = false })
            end,
        },
    },

    {
        "mrcjkb/haskell-tools.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim", -- optional
        },
        branch = "2.x.x",
    },
    {
        "tjdevries/ocaml.nvim",
        build = function()
            require("ocaml").update()
        end,
    },

    "lewis6991/gitsigns.nvim",
    {'akinsho/git-conflict.nvim', version = "*", config = true},

    -- notes stuff
    -- kw: markdown
    { "sotte/presenting.vim", lazy = true },
    "jghauser/follow-md-links.nvim",
    -- "nullchilly/fsread.nvim",

    "jbyuki/venn.nvim",
    "anuvyklack/hydra.nvim",
    {
        "phaazon/mind.nvim",
        branch = "v2.2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("mind").setup()
        end,
    },

    -- "nvim-orgmode/orgmode",
    { "michaelb/sniprun",      build = "bash ./install.sh" },
    { "kevinhwang91/nvim-ufo", dependencies = { "kevinhwang91/promise-async" } },
    "IndianBoy42/tree-sitter-just",
    -- "NoahTheDuke/vim-just",

    -- latex
    "lervag/vimtex",

    -- golang

    -- additional filetypes
    -- kitty.conf
    "fladson/vim-kitty",
    -- {
    --     "knubie/vim-kitty-navigator",
    --     build = "/bin/cp " .. vim.fn.stdpath("data") .. "/lazy/vim-kitty-navigator/*.py ~/.config/kitty/",
    -- },

    "christoomey/vim-tmux-navigator",

    "alexghergh/nvim-tmux-navigation"


    -- "edluffy/hologram.nvim",
}
