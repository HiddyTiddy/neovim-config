local HOME = os.getenv("HOME")

local function plug_path(plug_name)
    return HOME .. "/.config/nvim/rust-plugins/" .. plug_name
end

local function system_ext()
    return "so"
end

local function plugin_file_exists(plug_name)
    local path = plug_path(plug_name) .. "/lua/" .. plug_name .. "." .. system_ext()
    local file = io.open(path, "r")
    if file ~= nil then
        io.close(file)
        return true
    else
        return false
    end
end

local function register_plugin(plug_name)
    if not plugin_file_exists(plug_name) then
        vim.fn.systemlist(HOME .. "/.config/nvim/rust-plugins/install.sh " .. plug_path(plug_name))
    end
    vim.o.runtimepath = vim.o.runtimepath .. "," .. plug_path(plug_name)
end

register_plugin("hydutils")
register_plugin("task_manager")
