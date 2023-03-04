require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false,
    show_end_of_buffer = false, -- show the '~' characters after the end of buffers
    term_colors = false,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {
      mocha = {
        base = "#1E1E2E",
        mantle = "#1A1826",
        crust = "#161320",
      }
    },
    custom_highlights = {},
    integrations = {
      treesitter = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "undercurl" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
      },
      cmp = true,
      dap = { enabled = true, enable_ui = true },
      indent_blankline = { enabled = true, colored_indent_levels = false },
      markdown = true,
      mason = true,
      telescope = true,
      ts_rainbow = true,
      which_key = true,
    },
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
