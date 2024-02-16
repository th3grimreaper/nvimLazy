return {
  init_options = {
    cmd = { "ruff-lsp" },
    filetypes = { "python" },
    settings = {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  }
}
