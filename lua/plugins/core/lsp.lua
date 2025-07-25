local lspconfig = require("lspconfig")

require("luasnip.loaders.from_vscode").lazy_load()

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	-- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gI", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<space>lf", ":lua vim.lsp.buf.format({ async = true })<CR>", bufopts)
	vim.keymap.set("n", "<space>td", "<cmd>Telescope diagnostics<CR>", bufopts)
	vim.keymap.set("n", "<space>dh", "<cmd>DiffviewFileHistory<CR>", bufopts)
	vim.keymap.set("n", "<space>dch", "<cmd>DiffviewFileHistory %<CR>", bufopts)
end

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

-- Set up lspconfig.
local original_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require("blink.cmp").get_lsp_capabilities(original_capabilities)
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.

local servers = {
	"marksman",
	"htmx",
	"html",
	"cssls",
	"ts_ls",
	"jdtls",
	"lua_ls",
	"emmet_ls",
	"jsonls",
	"bashls",
	"pyright",
	"ruff",
	"svelte",
}

for _, sv in ipairs(servers) do
	lspconfig[sv].setup({
		on_attach = on_attach,
		flags = lsp_flags,
		capabilities = capabilities,
	})
end

-- tailwind
lspconfig.tailwindcss.setup(require("plugins.core.servers.tailwind"))

--eslint
lspconfig.eslint.setup(require("plugins.core.servers.eslint"))

--rust_analyzer
lspconfig.rust_analyzer.setup(require("plugins.core.servers.rust"))

--gopls
lspconfig.gopls.setup(require("plugins.core.servers.gopls"))

--clangd
lspconfig.clangd.setup(require("plugins.core.servers.clangd"))

--ruff-lsp
-- lspconfig.ruff.setup(require("plugins.core.servers.ruff"))
