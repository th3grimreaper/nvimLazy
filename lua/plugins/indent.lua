vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

require("ibl").setup {
  indent = {
    char = "▎",
    tab_char = "▎", -- This was the fix
  },
}
