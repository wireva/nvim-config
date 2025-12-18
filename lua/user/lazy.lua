-- install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
  "folke/which-key.nvim",
  { "folke/neoconf.nvim",   cmd = "Neoconf" },
  "folke/neodev.nvim",
  "nvim-lualine/lualine.nvim",
  "mbbill/undotree",
  "lewis6991/gitsigns.nvim",
  "nvim-tree/nvim-web-devicons",
  "MunifTanjim/prettier.nvim",
  "nvim-tree/nvim-tree.lua",
  "RRethy/vim-illuminate",
  "m4xshen/autoclose.nvim",
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { 'ThePrimeagen/harpoon', dependencies = { 'nvim-lua/plenary.nvim' } },
  "prichrd/netrw.nvim",
  "tpope/vim-fugitive",
  "ThePrimeagen/vim-be-good",
  "numToStr/Comment.nvim",
  "savq/melange-nvim", -- theme
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- 'stevearc/dressing.nvim',   -- optional for vim.ui.select
    },
    config = true,
  },
  {
    'dccsillag/magma-nvim',
    build = ":UpdateRemotePlugins"
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },

  -- Autocompletion
  { 'hrsh7th/nvim-cmp' },     -- Required
  { 'hrsh7th/cmp-nvim-lsp' }, -- Required
  { 'L3MON4D3/LuaSnip' },     -- Required
  { 'saadparwaiz1/cmp_luasnip' },
  { 'hrsh7th/cmp-cmdline' },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  { 'lambdalisue/vim-suda' },
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      -- vim.g.vimtex_view_method = "zathura"
    end
  }
})
