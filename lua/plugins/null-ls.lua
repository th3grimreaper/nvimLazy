local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local codeactions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics

local h = require("null-ls.helpers")
local cmd_resolver = require("null-ls.helpers.command_resolver")
local methods = require("null-ls.methods")
local u = require("null-ls.utils")

local FORMATTING = methods.internal.FORMATTING
local RANGE_FORMATTING = methods.internal.RANGE_FORMATTING

local sources = {
 formatting.prettierd.with({
  filetypes = { "html", "css", "scss", "json", "yaml", "markdown" },
  generator_opts = {
    command = "prettierd",
    args = function(params)
        if params.method == FORMATTING then
            return { "$FILENAME" }
        end

        local row, end_row = params.range.row - 1, params.range.end_row - 1
        local col, end_col = params.range.col - 1, params.range.end_col - 1
        local start_offset = vim.api.nvim_buf_get_offset(params.bufnr, row) + col
        local end_offset = vim.api.nvim_buf_get_offset(params.bufnr, end_row) + end_col

        return { "$FILENAME", "--range-start=" .. start_offset, "--range-end=" .. end_offset }
    end,
    dynamic_command = cmd_resolver.from_node_modules(),
    to_stdin = true,
    cwd = h.cache.by_bufnr(function(params)
        return u.root_pattern(
            -- https://prettier.io/docs/en/configuration.html
            ".prettierrc",
            ".prettierrc.json",
            ".prettierrc.yml",
            ".prettierrc.yaml",
            ".prettierrc.json5",
            ".prettierrc.js",
            ".prettierrc.cjs",
            ".prettierrc.toml",
            "prettier.config.js",
            "prettier.config.cjs",
            "package.json"
        )(params.bufname)
    end),
  },
  factory = h.formatter_factory,
 }),
 diagnostics.eslint,
 codeactions.eslint.with({
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  extra_args = { "-f", "json", "--stdin", "--stdin-filename", "$FILENAME" },
 }),
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(client, bufnr)
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
        vim.lsp.buf.format({bufnr = bufnr})
        end,
    })
  end
end


null_ls.setup({
  debug = true,
  sources = sources,
  on_attach = on_attach,
})
