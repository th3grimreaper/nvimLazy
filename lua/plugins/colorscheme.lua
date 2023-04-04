require("tokyonight").setup({
  style = "night", --storm, moon, night
  light_style = "day",
  transparent = true,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = { bold = true },
    variables = {},
    sidebars = "transparent",
    floats = "transparent",
  },
  sidebars = { "qf", "help" },
  day_brightness = 0.3,
  hide_inactive_statusline = false,
  dim_inactive = false,
  lualine_bold = false,

  on_colors = function(colors) end,

  on_highlights = function(highlights, colors) end,
})

vim.cmd("colorscheme tokyonight")
