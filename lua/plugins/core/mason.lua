require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		-- "emmet_ls",
		"html",
		"cssls",
		"vtsls",
		"eslint",
		"tailwindcss",
		"jsonls",
		"rust_analyzer",
		"clangd",
		"jdtls",
		"ruff",
		"basedpyright",
		"bashls",
		"eslint",
		"bashls",
		"htmx",
		"lua_ls",
		"gopls",
	},
	automatic_installation = true,
})
