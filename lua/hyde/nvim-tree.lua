vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "",
    staged = "ᛊ",
    -- staged = "S",
    unmerged = "",
    renamed = "➜",
    deleted = "",
    untracked = "ᚧ",
    -- untracked = "U",
    ignored = "◌",
  },
  folder = {
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
  },
}

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback


nvim_tree.setup {
  hijack_netrw = true,
    disable_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {
        "startify",
        "dashboard",
        "alpha",
    },
    auto_close = true,
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = true,
    update_to_buf_dir = {
        enable = true,
        auto_open = true,
    },
    diagnostics = {
        enable = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
    },
    system_open = {
        cmd = "open", -- open(1) on macOS
        args = {},
    },
    filters = {
        dotfiles = false,
        custom = {},
    },
    git = {
        enable = false, -- i think this hides ignored dirs
        ignore = false,
        timeout = 500,
    },
    view = {
        width = 30,
        height = 30,
        hide_root_folder = false,
        side = "left",
        auto_resize = true,
        mappings = {
            custom_only = false,
            list = {
                { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
                { key = "h", cb = tree_cb "close_node" },
                { key = "v", cb = tree_cb "vsplit" },
            },
        },
        number = false,
        relativenumber = false,
    },
    trash = {
        cmd = "trash",
        require_confirm = true,
    },
    quit_on_open = 0,
    git_hl = 1,
    disable_window_picker = 0,
    root_folder_modifier = ":t",
    show_icons = {
        git = 1,
        folders = 1,
        files = 1,
        folder_arrows = 1,
        tree_width = 30,
    },
}


-- keybindings
-- TODO make a help screen thingy for when i forger
-- {"<CR>", "o", "<2-LeftMouse>"}      "edit"
-- {"<2-RightMouse>", "<C-]>"},        "cd"
-- "<C-v>",                            "vsplit"
-- "<C-x>",                            "split"
-- "<C-t>",                            "tabnew"
-- "<",                                "prev_sibling"
-- ">",                                "next_sibling"
-- "P",                                "parent_node"
-- "<BS>",                             "close_node"
-- "<S-CR>",                           "close_node"
-- "<Tab>",                            "preview"
-- "K",                                "first_sibling"
-- "J",                                "last_sibling"
-- "I",                                "toggle_ignored"
-- "H",                                "toggle_dotfiles"
-- "R",                                "refresh"
-- "a",                                "create"
-- "d",                                "remove"
-- "D",                                "trash"
-- "r",                                "rename"
-- "<C-r>",                            "full_rename"
-- "x",                                "cut"
-- "c",                                "copy"
-- "p",                                "paste"
-- "y",                                "copy_name"
-- "Y",                                "copy_path"
-- "gy",                               "copy_absolute_path"
-- "[c",                               "prev_git_item"
-- "]c",                               "next_git_item"
-- "-",                                "dir_up"
-- "s",                                "system_open"
-- "q",                                "close"
-- "g?",                               "toggle_help"
