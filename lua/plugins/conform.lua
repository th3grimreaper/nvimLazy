vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*" },
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

require("conform").setup({
	formatters_by_ft = {
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescriptreact = { "prettierd" },
		svelte = { "prettierd" },
		css = { "prettierd" },
		scss = { "prettierd" },
		html = { "prettierd" },
		json = { "prettierd" },
		cpp = { "clang_format" },
		c = { "clang_format" },
		markdown = { "prettierd" },
		lua = { "stylua" },
		bash = { "shfmt" },
		golang = { "goimports" },
	},
	format_on_save = {
		timeout_ms = 500,
		async = false, -- not recommended to change
		quiet = false, -- not recommended to change
		lsp_fallback = true,
	},
})
