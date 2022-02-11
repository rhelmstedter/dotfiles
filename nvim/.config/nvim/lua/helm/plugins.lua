local fn = vim.fn
-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)

    use 'nvim-lualine/lualine.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'l3mon4d3/luasnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'rafamadriz/friendly-snippets'
    use 'th3whit3wolf/dusk-til-dawn.nvim'
    use 'akinsho/org-bullets.nvim'
    use 'brymer-meneses/grammar-guard.nvim'
    use 'dhruvasagar/vim-table-mode'
    use 'folke/zen-mode.nvim'
    use 'folke/twilight.nvim'
    use 'greghor/vim-pyshell'
    use 'honza/vim-snippets'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/nvim-cmp'
    use 'julienr/vim-cellmode'
    use 'kristijanhusak/orgmode.nvim'
    use 'lervag/vimtex'
    use 'markonm/traces.vim'
    use 'michal-h21/vim-zettel'
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use {'nvim-treesitter/nvim-treesitter', run = ':tsupdate'}
    use 'preservim/vimux'
    use 'reedes/vim-pencil'
    use 'ntbbloodbath/doom-one.nvim'
    use 'sbdchd/neoformat'
    use 'shime/vim-livedown'
    use 'numtostr/comment.nvim'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'
    use 'vimwiki/vimwiki'
    use 'voldikss/vim-floaterm'
    use 'williamboman/nvim-lsp-installer'
    use 'xiyaowong/nvim-transparent'
    use 'onsails/lspkind-nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
