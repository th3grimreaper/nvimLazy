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
    'stevearc/oil.nvim',
    keys = {
      {"-", "<CMD>Oil<CR>", mode = { "n" }},
    },
    config = function()
      require("plugins.oil")
    end,
  },
  {
    'nvim-telescope/telescope.nvim', version = '0.1.0',
            -- or                            , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
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
  { 'nvim-tree/nvim-web-devicons', },
  { 'mbbill/undotree' },
  { 
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require("plugins.null-ls")
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
    config = function()
      require("plugins.autopair")
    end,
  },
  { 
    'lukas-reineke/indent-blankline.nvim',
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
    'p00f/nvim-ts-rainbow',
    event = 'VeryLazy',
  },
  {'tpope/vim-surround'},
  {
     'goolord/alpha-nvim',
     config = function()
      require("plugins.alpha")
     end,
  },
  {'sindrets/diffview.nvim'},
  {
    'olexsmir/gopher.nvim',
    config = function()
      require("plugins.gopher")
    end,
  },
   --LSP
  {
    'williamboman/mason.nvim',
    -- event = "VeryLazy",
    config = function()
      require("plugins.core.mason")
    end,
  },
  {'williamboman/mason-lspconfig.nvim'},
  {
    'neovim/nvim-lspconfig',
    config = function()
      require("plugins.core.lsp")
    end,
  },
  --cmp
  {
    'hrsh7th/nvim-cmp', 
    event = "InsertEnter",
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

  -- { 'hrsh7th/cmp-buffer' },
  -- { 'hrsh7th/cmp-path' },
  -- { 'hrsh7th/cmp_luasnip' },
  -- { 'hrsh7th/cmp-nvim-lsp' },
  -- { 'hrsh7th/cmp-nvim-lua' },
	-- Snippets
  { 'L3MON4D3/LuaSnip' },
  { 'rafamadriz/friendly-snippets' },
}
