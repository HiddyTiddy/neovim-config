local autosave = require("hyde.tools.autosave")

autosave.setup({
    go = {
        execution = function(bufnr)
            local filename = vim.api.nvim_buf_get_name(bufnr)
            return { "go", "run", filename }
        end,
        pattern = "*.go",
    },

    ocaml = {
        pattern = { "*.ml", "*.mli" },
        execution = function()
            local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

            -- not 1000% fool proof but should work most of the time
            return { "dune", "exec", cwd }
        end,
    },

    rust = {
        pattern = "*.rs",
        execution = { "cargo", "run", "-q" },
    },
})
