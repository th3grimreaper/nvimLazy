require("mason").setup()
require("mason-lspconfig").setup({
   ensure_installed = { 
     -- "emmet_ls", 
     -- "html",
     -- "cssls",
     -- "ts_ls",
     "jsonls",
     -- "tailwindcss",
     "rust_analyzer",
     "clangd",
     "jdtls",
     "ruff_lsp",
     "pyright",
     "bashls"
   },
})
