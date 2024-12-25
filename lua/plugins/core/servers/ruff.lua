return {
  init_options = {
    cmd = { "ruff" },
    filetypes = { "python" },
    settings = {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  }
}
