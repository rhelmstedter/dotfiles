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

return packer.startup(function(use)

    -- auto complete
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-path"
    use "hrsh7th/nvim-cmp"

    -- lsp
    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer"

    -- IDE
    use "akinsho/toggleterm.nvim"
    use "markonm/traces.vim"
    use "mhartington/formatter.nvim"
    use "numtostr/comment.nvim"
    use "nvim-lua/plenary.nvim"
    use "nvim-lua/popup.nvim"
    use "ThePrimeagen/harpoon"
    use "tpope/vim-fugitive"
    use "tpope/vim-repeat"
    use "kylechui/nvim-surround"

    -- telescope
    use "nvim-telescope/telescope.nvim"
    use "nvim-telescope/telescope-fzy-native.nvim"

    -- snippets
    use "l3mon4d3/luasnip"
    use "rafamadriz/friendly-snippets"
    use "saadparwaiz1/cmp_luasnip"

    -- display
    use "folke/zen-mode.nvim"
    use "kyazdani42/nvim-web-devicons"
    use "ntbbloodbath/doom-one.nvim"
    use "nvim-lualine/lualine.nvim"
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    use 'nvim-treesitter/nvim-treesitter-context'
    use "onsails/lspkind-nvim"

    -- orgmode
    use "akinsho/org-bullets.nvim"
    use "dhruvasagar/vim-table-mode"
    use "kristijanhusak/orgmode.nvim"
    use 'simrat39/symbols-outline.nvim'

    -- python
    use 'eddiebergman/nvim-treesitter-pyfold'
    use "greghor/vim-pyshell"
    use "julienr/vim-cellmode"
    use "lervag/vimtex"
    use "preservim/vimux"
    use "python/black"
    use "shime/vim-livedown"
    use { "stsewd/isort.nvim", run = ":UpdateRemotePlugins" }

    -- zettelkasten
    use "junegunn/fzf"
    use "junegunn/fzf.vim"
    use "michal-h21/vim-zettel"
    use "preservim/vim-pencil"
    use "vimwiki/vimwiki"

end)

