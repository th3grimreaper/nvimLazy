require'nvim-treesitter.configs'.setup {
  context_commentstring = {
    enable = true
  },
  ensure_installed = {'lua', 'c', 'cpp', 'java', 'python', 'sql', 'scheme', 'html', 'javascript', 'css', 'typescript', 'tsx', 'scss', 'json', 'regex', 'vim', 'vimdoc', 'go'},
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  -- rainbow = {
  --   enable = false,
  --   query = 'rainbow-parens',
  --   -- Highlight the entire buffer all at once
  --   strategy = require('ts-rainbow').strategy.global,
  --   -- extended_mode = true,
  --   -- max_file_lines = nil,
  --   disable = {},
  -- },
  defaults = { file_ignore_patterns = { "node_modules" }}
}
