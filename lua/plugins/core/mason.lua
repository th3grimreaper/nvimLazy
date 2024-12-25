require("mason").setup()
require("mason-lspconfig").setup({
   ensure_installed = { 
     "emmet_ls", 
     "html",
     "cssls",
     "ts_ls",
     "tailwindcss",
     "jsonls",
     "gopls",
     "rust_analyzer",
     "clangd",
     "jdtls",
     "ruff",
     "pyright",
     "bashls"
   },
})
