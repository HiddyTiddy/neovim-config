local M = {}

---@param filename string
---@param output_buffer number
--- this function does hope that the filename is reasonable
M.generate = function(filename, output_buffer)
    local filename_safe = vim.fn.shellescape(filename)
    local command = "ocamlc -i " .. filename_safe
    local append_data = function(_, data)
        if data then
            vim.api.nvim_buf_set_lines(output_buffer, -1, -1, false, data)
        end
    end
    vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = append_data,
        on_stderr = append_data,
    })
end

--- registers commands
M.setup = function()
    vim.api.nvim_create_user_command("OcamlMli", function()
        local filename = vim.fn.expand("%")
        local output_filename = vim.fn.expand("%:r") .. ".mli"
        local output_buffer = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_set_current_buf(output_buffer)
        vim.api.nvim_buf_set_name(output_buffer, output_filename)
        M.generate(filename, output_buffer)
        vim.bo.filetype = "ocaml"
        vim.bo.buftype = ""
    end, {})
end

return M
