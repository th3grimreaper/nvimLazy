return {
  {
    -- 'catppuccin/nvim',
    -- name = 'catppuccin',
    -- 'rmehri01/onenord.nvim',
    'rebelot/kanagawa.nvim',
    config = function()
      require("plugins.colorscheme")
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
    config = function()
      require("plugins.lualine")
    end,
  },
  { 'nvim-tree/nvim-web-devicons', },
  { 'mbbill/undotree' },
  { 'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require("plugins.null-ls")
    end,
  },
  { 'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },
  { 'JoosepAlviste/nvim-ts-context-commentstring' },
  { 'windwp/nvim-autopairs',
    config = function()
      require("plugins.autopair")
    end,
  },
  { 'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("plugins.indent")
    end,
  },
  {'NvChad/nvim-colorizer.lua',
    config = function()
      require("plugins.colorizer")
    end,
  },
  {'p00f/nvim-ts-rainbow'},
  {'tpope/vim-surround'},
  {
     'goolord/alpha-nvim',
     config = function()
      require("plugins.alpha")
     end,
  },
  {'sindrets/diffview.nvim'},
  {'olexsmir/gopher.nvim',
    config = function()
      require("plugins.gopher")
    end,
  },
   --LSP
  {"williamboman/mason.nvim",
    config = function()
      require("plugins.mason")
    end,
  },
  {"williamboman/mason-lspconfig.nvim"},
  {"neovim/nvim-lspconfig",
    config = function()
      require("plugins.lsp")
    end,
  },
  --cmp
  {
    "hrsh7th/nvim-cmp", 
    config = function()
      require("plugins.cmp")
    end,
  },
  {"hrsh7th/cmp-buffer"},
  {"hrsh7th/cmp-path"},
  {"saadparwaiz1/cmp_luasnip"},
  {"hrsh7th/cmp-nvim-lsp"},
  {"hrsh7th/cmp-nvim-lua"},
	-- Snippets
   { "L3MON4D3/LuaSnip" },
   { "rafamadriz/friendly-snippets" },
}
