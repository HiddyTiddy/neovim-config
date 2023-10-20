local M = {}

local augroup

---@type table<number, {autocmd:number, parent:number, filetype:string, window:number}> current open sessions
local sessions = {}

---@alias execution string[]|(fun(bufnr: integer): string[])
---@alias config_entry { pattern: string|string[], execution: execution }

---@type table<string, config_entry>
local configs = {}

---@param filetype string
---@param execution execution
---@param pattern string|string[]
M.add_config = function(filetype, execution, pattern)
    configs[filetype] = { execution = execution, pattern = pattern }
end

local cleanup = function(session)
    vim.api.nvim_del_autocmd(session.autocmd)
end

---@param config? table<string, config_entry> how to execute each filetype
M.setup = function(config)
    if config then
        configs = config
    end

    augroup = vim.api.nvim_create_augroup("execOnSave", { clear = true })
    vim.api.nvim_create_autocmd("BufDelete", {
        pattern = "*",
        callback = function()
            local current_buffer = vim.api.nvim_get_current_buf()
            local session = sessions[current_buffer]
            if session == nil then
                return
            end
            cleanup(session)
            sessions[current_buffer] = nil
        end,
    })
end

local run_command = function(output_buffer, command)
    local append_data = function(_, data)
        if data then
            vim.api.nvim_buf_set_lines(output_buffer, -1, -1, false, data)
        end
    end

    vim.api.nvim_buf_set_lines(output_buffer, 0, -1, false, { "output: " })
    vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = append_data,
        on_stderr = append_data,
    })
end

local attach_to = function(output_buffer, pattern, command)
    if augroup == nil then
        augroup = vim.api.nvim_create_augroup("execOnSave", { clear = true })
    end
    return vim.api.nvim_create_autocmd("BufWritePost", {
        group = augroup,
        pattern = pattern,
        callback = function()
            run_command(output_buffer, command)
        end,
    })
end

local find_session = function(parent)
    for k, v in pairs(sessions) do
        if v.parent == parent then
            return k
        end
    end
end

M.start_buf_exec = function()
    local current_buffer = vim.api.nvim_get_current_buf()
    local current_win = vim.api.nvim_get_current_win()
    local filetype = vim.bo.filetype

    local existing_session = find_session(current_buffer)
    if existing_session then
        cleanup(sessions[existing_session])
        vim.api.nvim_win_close(sessions[existing_session].window, false)
        vim.api.nvim_buf_delete(existing_session, {force = true})
        sessions[existing_session] = nil
        return
    end

    local execution_scheme = configs[filetype]
    if execution_scheme == nil then
        print("no execution scheme for " .. filetype)
        return
    end

    vim.api.nvim_command("rightb vnew")
    local target_window = vim.api.nvim_get_current_win()
    local output_buffer = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_current_buf(output_buffer)

    vim.api.nvim_set_current_win(current_win)

    local command
    if type(execution_scheme.execution) == "function" then
        command = execution_scheme.execution(current_buffer)
    else
        command = execution_scheme.execution
    end

    run_command(output_buffer, command)
    local autocmd = attach_to(output_buffer, execution_scheme.pattern, command)

    sessions[output_buffer] =
    { autocmd = autocmd, parent = current_buffer, filetype = filetype, window = target_window }
end

return M
