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
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons'}
  },
  { 'nvim-telescope/telescope.nvim',
    dependencies = { 'sharkdp/fd', 
                     'nvim-lua/plenary.nvim',
		     { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
	    	   },
    config = function()
      require('config.telescope')
    end
  },
  { 'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-buffer',
                     'hrsh7th/cmp-path',
                     'L3MON4D3/LuaSnip',
                     'saadparwaiz1/cmp_luasnip',
                     'rafamadriz/friendly-snippets',},
  },
  { 'mcchrish/zenbones.nvim',
    dependencies = {'rktjmp/lush.nvim'},
    priority = 1000,
    config = function()
      require('config.zenbones')
    end
  },
  { 'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeoutlen = 500
      vim.o.timeout = true
    end
  },
  checker = {
    enabled = true,
    notify = false
  },
  change_detection = {
    notify = false
  }
})
