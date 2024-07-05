-- Ensure Lazy is installed
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

require("lazy").setup({
  {
    "catppuccin/nvim",
    -- lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    name = "catppuccin",
    config = function()
      require("mcritchlow.plugins.config.theme")
    end,
  },
  -- Utils
  "tpope/vim-repeat",
  {
    "tpope/vim-markdown",
    config = function()
      require("mcritchlow.plugins.config.markdown")
    end,
  },
  "tpope/vim-fugitive",
  "tpope/vim-surround",
  "whiteinge/diffconflicts",
  { "christoomey/vim-sort-motion",  lazy = false },
  "folke/neodev.nvim",
  {
    "ThePrimeagen/harpoon",
    config = function()
      require("mcritchlow.plugins.config.harpoon")
    end,
  },
  { "kyazdani42/nvim-web-devicons", name = "nvim-web-devicons" },
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = {
      "nvim-web-devicons",
    },
    config = function()
      require("mcritchlow.plugins.config.nvimtree")
    end,
  },
  {
    "vim-test/vim-test",
    config = function()
      require("mcritchlow.plugins.config.vim_test")
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("mcritchlow.plugins.config.comment")
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "hrsh7th/vim-vsnip-integ",
      "nvim-web-devicons",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("mcritchlow.plugins.config.cmp")
    end,
  },
  { "nvim-lua/plenary.nvim", name = "plenary.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "plenary.nvim",
      "cwebster2/github-coauthors.nvim",
    },
    config = function()
      require("mcritchlow.plugins.config.telescope")
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make"
  },
  "stevearc/dressing.nvim",
  -- LSP
  "b0o/SchemaStore.nvim",
  "onsails/lspkind-nvim",
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mcritchlow.lsp")
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "plenary.nvim" },
  },
  {
    "folke/trouble.nvim",
    config = function()
      require("mcritchlow.plugins.config.trouble")
    end,
  },
  { "kana/vim-textobj-user", name = "vim-textobj-user" },
  {
    "kana/vim-textobj-indent",
    dependencies = { "vim-textobj-user" },
  },
  {
    "nelstrom/vim-textobj-rubyblock",
    dependencies = { "vim-textobj-user" },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "theHamsta/nvim-dap-virtual-text",
      "ray-x/guihua.lua",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("mcritchlow.plugins.config.dap")
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "williamboman/mason-lspconfig",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
    config = function()
      require("mcritchlow.plugins.config.go")
    end,
  },

  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("mcritchlow.plugins.config.lsp_signature")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-textobjects"
    },
    build = ":TSUpdate",
    config = function()
      require("mcritchlow.plugins.config.treesitter")
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("mcritchlow.plugins.config.colorizer")
    end,
  },
  "sheerun/vim-polyglot",
  "vim-ruby/vim-ruby",
})
