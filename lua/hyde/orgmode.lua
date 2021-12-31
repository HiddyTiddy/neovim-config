local ok, parsers = pcall(require, "nvim-treesitter.parsers")
if not ok then
	return
end

local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
	return
end

local ok, orgmode = pcall(require, "orgmode")
if not ok then
	return
end

local parser_config = parsers.get_parser_configs()
parser_config.org = {
	install_info = {
		url = "https://github.com/milisims/tree-sitter-org",
		revision = "f110024d539e676f25b72b7c80b0fd43c34264ef",
		files = { "src/parser.c", "src/scanner.cc" },
	},
	filetype = "org",
}

orgmode.setup({
	org_agenda_files = { "~/Dropbox/org/*", "~/my-orgs/**/*" },
	org_default_notes_file = "~/Dropbox/org/refile.org",
})

