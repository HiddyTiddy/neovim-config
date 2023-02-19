-- /Users/hasenmafia/.local/share/nvim/site/pack/packer/start/vimspector/gadgets/macos/.gadgets.d/lldb-vscode.json
vim.cmd([[
let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_base_dir='/Users/hasenmafia/.local/share/nvim/site/pack/packer/start/vimspector'
nnoremap <Leader>dj <Plug>VimspectorStepOver<CR>
nnoremap <Leader>dl <Plug>VimspectorStepInto<CR>
nnoremap <Leader>dk <Plug>VimspectorStepOut<CR>
nnoremap <Leader>db <Plug>VimspectorToggleBreakpoint<CR>
nnoremap <Leader>dr <Plug>VimspectorRunToCursor<CR>
]])
