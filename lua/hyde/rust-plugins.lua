local HOME = os.getenv("HOME")
local function register_plugin(plug_name)
    vim.o.runtimepath = vim.o.runtimepath .. "," .. HOME .. "/.config/nvim/rust-plugins/" .. plug_name
end

register_plugin("hydutils")
