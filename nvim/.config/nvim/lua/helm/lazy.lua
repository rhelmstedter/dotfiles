local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",         -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

local plugins = {
    -- auto complete and lsp
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/vim-vsnip",
    'hrsh7th/cmp-nvim-lsp-signature-help',
    "nvim-lua/plenary.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",

    -- codeium
    {
        "Exafunction/codeium.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
    },

    -- IDE
    "AckslD/nvim-neoclip.lua",
    {
        'stevearc/oil.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    "akinsho/toggleterm.nvim",
    -- "markonm/traces.vim",
    "numtostr/comment.nvim",
    "nvim-lua/popup.nvim",
    "ThePrimeagen/harpoon",
    "tpope/vim-fugitive",
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup()
        end
    },
    "tpope/vim-repeat",
    "kylechui/nvim-surround",
    "mbbill/undotree",
    "ggandor/leap.nvim",
    "ThePrimeagen/refactoring.nvim",
    "dhruvasagar/vim-table-mode",

    -- telescope
    "nvim-telescope/telescope.nvim",
    {"nvim-telescope/telescope-fzy-native.nvim", build = "make" },

    -- snippets
    { "L3MON4D3/LuaSnip", run = "make install_jsregexp" },
    "rafamadriz/friendly-snippets",
    "saadparwaiz1/cmp_luasnip",

    -- themes
    "NTBBloodbath/doom-one.nvim",
    -- {
    --     'AlexvZyl/nordic.nvim',
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require('nordic').load()
    --     end
    -- },

    { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
    -- display
    "folke/zen-mode.nvim",
    "kyazdani42/nvim-web-devicons",
    "nvim-lualine/lualine.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- 'm-demare/hlargs.nvim',
    "onsails/lspkind-nvim",

    -- orgmode
    "nvim-orgmode/orgmode",

    -- data science in python
    "greghor/vim-pyshell",
    "julienr/vim-cellmode",
    "lervag/vimtex",
    "preservim/vimux",
    "shime/vim-livedown",

    -- rust
    'rust-lang/rust.vim',
    {
        'mrcjkb/rustaceanvim',
        version = '^3',
        ft = { 'rust' },
    },
    -- zettelkasten
    "junegunn/fzf",
    "junegunn/fzf.vim",
    "michal-h21/vim-zettel",
    "preservim/vim-pencil",
    {
        "andrewferrier/wrapping.nvim",
        config = function()
            require("wrapping").setup()
        end
    }
}

require("lazy").setup(plugins, {})
