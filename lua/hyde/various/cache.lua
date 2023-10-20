local M = {}

local function gettime()
    ---@diagnostic disable-next-line: param-type-mismatch
    return os.time(os.date("!*t"))
end

M.single = function(setter, expiration_time_sec)
    if expiration_time_sec == nil then
        expiration_time_sec = 2
    end

    local x = {
        value = nil,
        setter = setter,
        last_updated = 0,
        expiration = expiration_time_sec,
    }

    function x:get()
        local now = gettime()
        if self.last_updated + self.expiration < now then
            self.value = self.setter()
            self.last_updated = now
        end
        return self.value
    end

    return x
end

return M
