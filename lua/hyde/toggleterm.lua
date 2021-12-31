local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	size = 20,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal

-- test if program is installed
local function exists(command)
	local result = { os.execute(command .. " 2>/dev/null 1>/dev/null") }

	local out = result[1]
	-- what
	return out == 0
end

if exists("lazygit --version") then
	local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
	function _LAZYGIT_TOGGLE()
		lazygit:toggle()
	end
else
	function _LAZYGIT_TOGGLE()
		print("lazygit not installed")
	end
end

if exists("node --version") then
	local node = Terminal:new({ cmd = "node", hidden = true })

	function _NODE_TOGGLE()
		node:toggle()
	end
else
	function _NODE_TOGGLE()
		print("node not installed (or `node` is not the name of the executable)")
	end
end

if exists("deno --version") then
	local deno = Terminal:new({ cmd = "deno", hidden = true })

	function _DENO_TOGGLE()
		deno:toggle()
	end
else
	function _DENO_TOGGLE()
		print("deno is not installed")
	end
end

if exists("lua --version") then
	local lua_term = Terminal:new({ cmd = "lua", hidden = true })

	function _LUA_TOGGLE()
		lua_term:toggle()
	end
else
	function _LUA_TOGGLE()
        print("lua not installed")
	end
end

if exists("ncdu --version") then
	local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })

	function _NCDU_TOGGLE()
		ncdu:toggle()
	end
else
	function _NCDU_TOGGLE()
        print("ncdu not installed")
	end
end

if exists("ytop --version") then
	local ytop = Terminal:new({ cmd = "ytop", hidden = true })

	function _YTOP_TOGGLE()
		ytop:toggle()
	end
else
	function _YTOP_TOGGLE()
        print("ytop not installed")
	end
end

if exists("python3 --version") then
	local python = Terminal:new({ cmd = "python3", hidden = true })

	function _PYTHON_TOGGLE()
		python:toggle()
	end
else
	function _PYTHON_TOGGLE()
        print("python3 not installed")
	end
end
