vim.cmd([[
let g:opamshare = substitute(system('opam var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
execute "helptags " . substitute(system('opam var share'),'\n$','','''') .  "/merlin/vim/doc"
]])

vim.g.no_ocaml_maps = true

local nvim_lspconfig = require("lspconfig")
nvim_lspconfig.ocamllsp.setup({
    cmd = { "ocamllsp" },
    filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
    root_dir = nvim_lspconfig.util.root_pattern(
        "*.opam",
        "esy.json",
        "package.json",
        ".git",
        "dune-project",
        "dune-workspace"
    ),
    on_attach = require("hyde.lsp.handlers").on_attach,
    capabilities = require("hyde.lsp.handlers").capabilities,
})
