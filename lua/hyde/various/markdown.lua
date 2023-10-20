local M = {}

M.toggle_todo = function()
  local cur_line = vim.api.nvim_get_current_line()
  local found_undone = string.find(cur_line, "[ ]")
  local found_done = string.find(cur_line, "[x]")

  if found_done and found_undone then
    local changed_line
    if found_done < found_undone then
      changed_line = string.gsub(cur_line, "%[x%]", "[ ]", 1)
    else
      changed_line = string.gsub(cur_line, "%[ %]", "[x]", 1)
    end
    vim.api.nvim_set_current_line(changed_line)
  elseif found_undone then
    local changed_line = string.gsub(cur_line, "%[ %]", "[x]", 1)
    vim.api.nvim_set_current_line(changed_line)
  elseif found_done then
    local changed_line = string.gsub(cur_line, "%[x%]", "[ ]", 1)
    vim.api.nvim_set_current_line(changed_line)
  end
end

M.setup = function(opts)
  local groupid = vim.api.nvim_create_augroup("Markdown", { clear = false })

  local opt = {}
  if opts ~= nil then
    opt = opts.options or {}
  end

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    callback = function()
      if vim.o.ft ~= "markdown" then
        return
      end
      for k, v in pairs(opt) do
        vim.opt_local[k] = v
      end

      vim.cmd([[so ~/.config/nvim/after/syntax/markdown.lua]])
    end,
  })

  vim.cmd(
    [[autocmd FileType markdown map <buffer> <leader><leader> <cmd>lua require("hyde.various.markdown").toggle_todo()<CR>]]
  )
end

return M
