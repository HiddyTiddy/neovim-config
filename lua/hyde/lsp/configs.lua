local configs = {
    ["typescript-tools"] = {
        shiftwidth = 2,
    },
    ocaml = {
        shiftwidth = 2,
    },
    cssls = {
        shiftwidth = 2,
    },
    html = {
        shiftwidth = 2,
    },
    c = {
        shiftwidth = 8,
    },
}

local set_opt = function(key, opt)
    if opt == nil then
        return
    end
    vim.opt_local[key] = opt
end

local set_config = function(conf)
    if conf == nil then
        return
    end
    set_opt("shiftwidth", conf.shiftwidth)
end

return { configs = configs, set_config = set_config }
