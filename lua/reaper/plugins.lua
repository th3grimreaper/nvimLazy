return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require("plugins.colorscheme")
    end
  },
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>b", "<cmd>Neotree toggle<CR>", mode = { "n" }, desc = "Neotree" },
    },
  },
  { 'nvim-tree/nvim-web-devicons' },
  {
    'eandrju/cellular-automaton.nvim',
    keys = {
      { "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>", desc = "Make it Rain" },
    },
  },
  {
      "pmizio/typescript-tools.nvim",
      event = "LspAttach",
      opts = {},
      config = function()
        require("typescript-tools").setup{}
      end,
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    event = "LspAttach",
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        lightbulb = {
          enable = false,
        },
      })
    end,
  },
  {
    'stevearc/dressing.nvim',
    event = "BufReadPre",
    config = function()
      require('dressing').setup()
    end
  },
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    -- optionally, override the default options:
    event = "VeryLazy",
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
      require("cmp").setup({
        formatting = { format = require("tailwindcss-colorizer-cmp").formatter }
      })
    end
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.3',
            -- or                            , branch = '0.1.x',
    dependencies = { 
      'nvim-lua/plenary.nvim'
    },
    -- keys = {
    --   { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    --   -- add a keymap to browse plugin files
    --   {
    --     "<leader>fp",
    --     function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
    --     desc = "Find Plugin File",
    --   },
    -- },
    event = "VeryLazy",
    config = function()
      require("plugins.telescope")
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter', 
    build = ':TSUpdate',
    config = function()
      require("plugins.treesitter")
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    config = function()
      require("plugins.lualine")
    end,
  },
  { 
    'mbbill/undotree',
    keys = { 
      { "<leader>u", "<cmd>UndotreeToggle<CR>" , { mode = "n" }, desc = "UndoTree" },
    },
  },
  { 
    'jose-elias-alvarez/null-ls.nvim',
    event = "BufReadPre",
    config = function()
      require("plugins.core.null-ls")
    end,
  },
  { 
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },
  { 
    'JoosepAlviste/nvim-ts-context-commentstring',
    event = 'VeryLazy',
  },
  { 
    'windwp/nvim-autopairs',
    event = "BufReadPre",
    config = function()
      require("plugins.autopair")
    end,
  },
  { 
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    config = function()
      require("plugins.indent")
    end,
  },
  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require("plugins.colorizer")
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup()
    end
  },
  {
     'goolord/alpha-nvim',
     config = function()
      require("plugins.alpha")
     end,
  },
  {'sindrets/diffview.nvim'},
   --LSP
  {
    'williamboman/mason.nvim',
    -- event = "VeryLazy",
    cmd = "Mason",
    event = "BufReadPre",
    config = function()
      require("plugins.core.mason")
    end,
  },
  {'williamboman/mason-lspconfig.nvim'},
  {
    'neovim/nvim-lspconfig',
    event = "BufReadPre",
    config = function()
      require("plugins.core.lsp")
    end,
  },
  --cmp
  {
    'hrsh7th/nvim-cmp', 
    -- event = "InsertEnter",
    event = "BufReadPre",
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
    },
    config = function()
      require("plugins.core.cmp")
    end,
  },
	-- Snippets
  { 
    'L3MON4D3/LuaSnip',
    event = "LspAttach",
  },
  { 'rafamadriz/friendly-snippets' },
}
