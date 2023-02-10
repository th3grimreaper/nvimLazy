local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("reaper.keymaps")
require("reaper.options")

require("lazy").setup({
  {
    'sainnhe/gruvbox-material',
    config = function()
      require("plugins.colorscheme")
    end,
  },
   {
    'nvim-telescope/telescope.nvim', version = '0.1.0',
            -- or                            , branch = '0.1.x',
    dependencies = { {'nvim-lua/plenary.nvim'} },
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
  { 'tpope/vim-vinegar' },
  { 'jose-elias-alvarez/null-ls.nvim' },
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
})
