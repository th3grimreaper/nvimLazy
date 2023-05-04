return {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = {
        fillstruct = false
      }
    }
  }
}
