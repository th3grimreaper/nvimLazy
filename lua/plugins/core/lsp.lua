local lspconfig = require("lspconfig")

-- require("luasnip.loaders.from_vscode").lazy_load()
--
-- -- Mappings.
-- -- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- local opts = { noremap = true, silent = true }
-- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
-- -- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
-- -- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
-- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
--
-- -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
-- -- 	border = "rounded",
-- -- })
--
-- -- Use an on_attach function to only map the following keys
-- -- after the language server attaches to the current buffer
-- local on_attach = function(client, bufnr)
-- 	-- Enable completion triggered by <c-x><c-o>
-- 	-- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
--
-- 	-- Mappings.
-- 	-- See `:help vim.lsp.*` for documentation on any of the below functions
-- 	local bufopts = { noremap = true, silent = true, buffer = bufnr }
-- 	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
-- 	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
-- 	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
-- 	vim.keymap.set("n", "gI", vim.lsp.buf.implementation, bufopts)
-- 	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
-- 	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
-- 	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
-- 	vim.keymap.set("n", "<space>wl", function()
-- 		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
-- 	end, bufopts)
-- 	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
-- 	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
-- 	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
-- 	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
-- 	vim.keymap.set("n", "<space>lf", ":lua vim.lsp.buf.format({ async = true })<CR>", bufopts)
-- 	vim.keymap.set("n", "<space>dh", "<cmd>DiffviewFileHistory<CR>", bufopts)
-- 	vim.keymap.set("n", "<space>dch", "<cmd>DiffviewFileHistory %<CR>", bufopts)
-- end
--
-- local lsp_flags = {
-- 	-- This is the default in Nvim 0.7+
-- 	debounce_text_changes = 150,
-- }
--
-- -- Set up lspconfig.
-- local original_capabilities = vim.lsp.protocol.make_client_capabilities()
-- local capabilities = require("blink.cmp").get_lsp_capabilities(original_capabilities)
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- local capabilities = vim.lsp.protocol.make_client_capabilities()

local servers = {
	"htmx",
	"html",
	"cssls",
	-- "ts_ls",
	"vtsls",
	"jdtls",
	"lua_ls",
	"emmet_ls",
	"jsonls",
	"bashls",
	"basedpyright",
	"ruff",
	"svelte",
	"clangd",
	"eslint",
	"gopls",
	"rust_analyzer",
	"tailwindcss",
	"elixirls",
}

vim.lsp.enable(servers)

---
---
vim.diagnostic.config({
	-- virtual_text = true,
	underline = true,
	virtual_lines = {
		current_line = true,
	},
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})

local function restart_lsp(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	local clients
	if vim.lsp.get_clients then
		clients = vim.lsp.get_clients({ bufnr = bufnr })
	else
		---@diagnostic disable-next-line: deprecated
		clients = vim.lsp.get_active_clients({ bufnr = bufnr })
	end

	for _, client in ipairs(clients) do
		vim.lsp.stop_client(client.id)
	end

	vim.defer_fn(function()
		vim.cmd("edit")
	end, 100)
end

vim.api.nvim_create_user_command("LspRestart", function()
	restart_lsp()
end, {})

local function lsp_status()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients and vim.lsp.get_clients({ bufnr = bufnr })
		or vim.lsp.get_active_clients({ bufnr = bufnr })

	if #clients == 0 then
		print("󰅚 No LSP clients attached")
		return
	end

	print("󰒋 LSP Status for buffer " .. bufnr .. ":")
	print("─────────────────────────────────")

	for i, client in ipairs(clients) do
		print(string.format("󰌘 Client %d: %s (ID: %d)", i, client.name, client.id))
		print("  Root: " .. (client.config.root_dir or "N/A"))
		print("  Filetypes: " .. table.concat(client.config.filetypes or {}, ", "))

		-- Check capabilities
		local caps = client.server_capabilities
		local features = {}
		if caps.completionProvider then
			table.insert(features, "completion")
		end
		if caps.hoverProvider then
			table.insert(features, "hover")
		end
		if caps.definitionProvider then
			table.insert(features, "definition")
		end
		if caps.referencesProvider then
			table.insert(features, "references")
		end
		if caps.renameProvider then
			table.insert(features, "rename")
		end
		if caps.codeActionProvider then
			table.insert(features, "code_action")
		end
		if caps.documentFormattingProvider then
			table.insert(features, "formatting")
		end

		print("  Features: " .. table.concat(features, ", "))
		print("")
	end
end

vim.api.nvim_create_user_command("LspStatus", lsp_status, { desc = "Show detailed LSP status" })

local function check_lsp_capabilities()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients and vim.lsp.get_clients({ bufnr = bufnr })
		or vim.lsp.get_active_clients({ bufnr = bufnr })

	if #clients == 0 then
		print("No LSP clients attached")
		return
	end

	for _, client in ipairs(clients) do
		print("Capabilities for " .. client.name .. ":")
		local caps = client.server_capabilities

		local capability_list = {
			{ "Completion", caps.completionProvider },
			{ "Hover", caps.hoverProvider },
			{ "Signature Help", caps.signatureHelpProvider },
			{ "Go to Definition", caps.definitionProvider },
			{ "Go to Declaration", caps.declarationProvider },
			{ "Go to Implementation", caps.implementationProvider },
			{ "Go to Type Definition", caps.typeDefinitionProvider },
			{ "Find References", caps.referencesProvider },
			{ "Document Highlight", caps.documentHighlightProvider },
			{ "Document Symbol", caps.documentSymbolProvider },
			{ "Workspace Symbol", caps.workspaceSymbolProvider },
			{ "Code Action", caps.codeActionProvider },
			{ "Code Lens", caps.codeLensProvider },
			{ "Document Formatting", caps.documentFormattingProvider },
			{ "Document Range Formatting", caps.documentRangeFormattingProvider },
			{ "Rename", caps.renameProvider },
			{ "Folding Range", caps.foldingRangeProvider },
			{ "Selection Range", caps.selectionRangeProvider },
		}

		for _, cap in ipairs(capability_list) do
			local status = cap[2] and "✓" or "✗"
			print(string.format("  %s %s", status, cap[1]))
		end
		print("")
	end
end

vim.api.nvim_create_user_command("LspCapabilities", check_lsp_capabilities, { desc = "Show LSP capabilities" })

local function lsp_diagnostics_info()
	local bufnr = vim.api.nvim_get_current_buf()
	local diagnostics = vim.diagnostic.get(bufnr)

	local counts = { ERROR = 0, WARN = 0, INFO = 0, HINT = 0 }

	for _, diagnostic in ipairs(diagnostics) do
		local severity = vim.diagnostic.severity[diagnostic.severity]
		counts[severity] = counts[severity] + 1
	end

	print("󰒡 Diagnostics for current buffer:")
	print("  Errors: " .. counts.ERROR)
	print("  Warnings: " .. counts.WARN)
	print("  Info: " .. counts.INFO)
	print("  Hints: " .. counts.HINT)
	print("  Total: " .. #diagnostics)
end

vim.api.nvim_create_user_command("LspDiagnostics", lsp_diagnostics_info, { desc = "Show LSP diagnostics count" })

local function lsp_info()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients and vim.lsp.get_clients({ bufnr = bufnr })
		or vim.lsp.get_active_clients({ bufnr = bufnr })

	print("═══════════════════════════════════")
	print("           LSP INFORMATION          ")
	print("═══════════════════════════════════")
	print("")

	-- Basic info
	print("󰈙 Language client log: " .. vim.lsp.get_log_path())
	print("󰈔 Detected filetype: " .. vim.bo.filetype)
	print("󰈮 Buffer: " .. bufnr)
	print("󰈔 Root directory: " .. (vim.fn.getcwd() or "N/A"))
	print("")

	if #clients == 0 then
		print("󰅚 No LSP clients attached to buffer " .. bufnr)
		print("")
		print("Possible reasons:")
		print("  • No language server installed for " .. vim.bo.filetype)
		print("  • Language server not configured")
		print("  • Not in a project root directory")
		print("  • File type not recognized")
		return
	end

	print("󰒋 LSP clients attached to buffer " .. bufnr .. ":")
	print("─────────────────────────────────")

	for i, client in ipairs(clients) do
		print(string.format("󰌘 Client %d: %s", i, client.name))
		print("  ID: " .. client.id)
		print("  Root dir: " .. (client.config.root_dir or "Not set"))
		print("  Command: " .. table.concat(client.config.cmd or {}, " "))
		print("  Filetypes: " .. table.concat(client.config.filetypes or {}, ", "))

		-- Server status
		if client.is_stopped() then
			print("  Status: 󰅚 Stopped")
		else
			print("  Status: 󰄬 Running")
		end

		-- Workspace folders
		if client.workspace_folders and #client.workspace_folders > 0 then
			print("  Workspace folders:")
			for _, folder in ipairs(client.workspace_folders) do
				print("    • " .. folder.name)
			end
		end

		-- Attached buffers count
		local attached_buffers = {}
		for buf, _ in pairs(client.attached_buffers or {}) do
			table.insert(attached_buffers, buf)
		end
		print("  Attached buffers: " .. #attached_buffers)

		-- Key capabilities
		local caps = client.server_capabilities
		local key_features = {}
		if caps.completionProvider then
			table.insert(key_features, "completion")
		end
		if caps.hoverProvider then
			table.insert(key_features, "hover")
		end
		if caps.definitionProvider then
			table.insert(key_features, "definition")
		end
		if caps.documentFormattingProvider then
			table.insert(key_features, "formatting")
		end
		if caps.codeActionProvider then
			table.insert(key_features, "code_action")
		end

		if #key_features > 0 then
			print("  Key features: " .. table.concat(key_features, ", "))
		end

		print("")
	end

	-- Diagnostics summary
	local diagnostics = vim.diagnostic.get(bufnr)
	if #diagnostics > 0 then
		print("󰒡 Diagnostics Summary:")
		local counts = { ERROR = 0, WARN = 0, INFO = 0, HINT = 0 }

		for _, diagnostic in ipairs(diagnostics) do
			local severity = vim.diagnostic.severity[diagnostic.severity]
			counts[severity] = counts[severity] + 1
		end

		print("  󰅚 Errors: " .. counts.ERROR)
		print("  󰀪 Warnings: " .. counts.WARN)
		print("  󰋽 Info: " .. counts.INFO)
		print("  󰌶 Hints: " .. counts.HINT)
		print("  Total: " .. #diagnostics)
	else
		print("󰄬 No diagnostics")
	end

	print("")
	print("Use :LspLog to view detailed logs")
	print("Use :LspCapabilities for full capability list")
end

-- Create command
vim.api.nvim_create_user_command("LspInfo", lsp_info, { desc = "Show comprehensive LSP information" })

local function lsp_status_short()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients and vim.lsp.get_clients({ bufnr = bufnr })
		or vim.lsp.get_active_clients({ bufnr = bufnr })

	if #clients == 0 then
		return "" -- Return empty string when no LSP
	end

	local names = {}
	for _, client in ipairs(clients) do
		table.insert(names, client.name)
	end

	return "󰒋 " .. table.concat(names, ",")
end

local function git_branch()
	local ok, handle = pcall(io.popen, "git branch --show-current 2>/dev/null")
	if not ok or not handle then
		return ""
	end
	local branch = handle:read("*a")
	handle:close()
	if branch and branch ~= "" then
		branch = branch:gsub("\n", "")
		return "󰊢 " .. branch
	end
	return ""
end
-- Safe wrapper functions for statusline
local function safe_git_branch()
	local ok, result = pcall(git_branch)
	return ok and result or ""
end

local function safe_lsp_status()
	local ok, result = pcall(lsp_status_short)
	return ok and result or ""
end

_G.git_branch = safe_git_branch
_G.lsp_status = safe_lsp_status

-- THEN set the statusline
vim.opt.statusline = table.concat({
	"%{v:lua.git_branch()}", -- Git branch
	"%f", -- File name
	"%m", -- Modified flag
	"%r", -- Readonly flag
	"%=", -- Right align
	"%{v:lua.lsp_status()}", -- LSP status
	" %l:%c", -- Line:Column
	" %p%%", -- Percentage through file
}, " ")

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufopts = { noremap = true, silent = true, buffer = args.buf }
		vim.keymap.set("i", "<C-Space>", function()
			vim.lsp.completion.get()
		end)
		vim.keymap.set("n", "K", vim.lsp.buf.declaration, bufopts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
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
		vim.keymap.set("n", "<space>dh", "<cmd>DiffviewFileHistory<CR>", bufopts)
		vim.keymap.set("n", "<space>dch", "<cmd>DiffviewFileHistory %<CR>", bufopts)
	end,
})
---
---

-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	callback = function(ev)
-- 		local client = vim.lsp.get_client_by_id(ev.data.client_id)
-- 		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
-- 			vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
-- 			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
-- 			vim.keymap.set("i", "<C-Space>", function()
-- 				vim.lsp.completion.get()
-- 			end)
-- 			local bufopts = { noremap = true, silent = true, buffer = ev.buf }
-- 			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
-- 			vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
-- 			vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
-- 			vim.keymap.set("n", "gI", vim.lsp.buf.implementation, bufopts)
-- 			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
-- 			vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
-- 			vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
-- 			vim.keymap.set("n", "<space>wl", function()
-- 				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
-- 			end, bufopts)
-- 			vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
-- 			vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
-- 			vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
-- 			vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
-- 			vim.keymap.set("n", "<space>lf", ":lua vim.lsp.buf.format({ async = true })<CR>", bufopts)
-- 			vim.keymap.set("n", "<space>dh", "<cmd>DiffviewFileHistory<CR>", bufopts)
-- 			vim.keymap.set("n", "<space>dch", "<cmd>DiffviewFileHistory %<CR>", bufopts)
-- 		end
-- 	end,
-- })
--
-- -- Diagnostics
-- vim.diagnostic.config({
-- 	-- Use the default configuration
-- 	-- virtual_lines = true
--
-- 	-- Alternatively, customize specific options
-- 	virtual_lines = {
-- 		-- Only show virtual line diagnostics for the current cursor line
-- 		current_line = true,
-- 	},
-- })

-- for _, sv in ipairs(servers) do
-- 	lspconfig[sv].setup({
-- 		on_attach = on_attach,
-- 		flags = lsp_flags,
-- 		capabilities = capabilities,
-- 	})
-- end

-- tailwind
-- lspconfig.tailwindcss.setup(require("plugins.core.servers.tailwind"))
--
-- --eslint
-- lspconfig.eslint.setup(require("plugins.core.servers.eslint"))
--
-- --rust_analyzer
-- lspconfig.rust_analyzer.setup(require("plugins.core.servers.rust"))
--
-- --gopls
-- lspconfig.gopls.setup(require("plugins.core.servers.gopls"))
--
-- --clangd
-- lspconfig.clangd.setup(require("plugins.core.servers.clangd"))

--ruff-lsp
-- lspconfig.ruff.setup(require("plugins.core.servers.ruff"))
