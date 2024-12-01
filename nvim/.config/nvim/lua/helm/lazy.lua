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

vim.g.mapleader = " "

local plugins = {

    -- auto complete
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/nvim-cmp",
    "hrsh7th/vim-vsnip",
    'hrsh7th/cmp-nvim-lsp-signature-help',
    "nvim-lua/plenary.nvim",

    -- lsp
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
    "markonm/traces.vim",
    "mhartington/formatter.nvim",
    "numtostr/comment.nvim",
    "nvim-lua/popup.nvim",
    "ThePrimeagen/harpoon",
    "tpope/vim-fugitive",
    "tpope/vim-repeat",
    "kylechui/nvim-surround",
    "mbbill/undotree",
    "ggandor/leap.nvim",
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("refactoring").setup()
        end,
    },

    -- telescope
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-fzy-native.nvim",

    -- snippets
    "l3mon4d3/luasnip",
    "rafamadriz/friendly-snippets",
    "saadparwaiz1/cmp_luasnip",

    -- display
    "folke/zen-mode.nvim",
    "kyazdani42/nvim-web-devicons",
    "NTBBloodbath/doom-one.nvim",
    "nvim-lualine/lualine.nvim",
    "nvim-treesitter/nvim-treesitter",
    'm-demare/hlargs.nvim',
    build = ":TSUpdate",
    "onsails/lspkind-nvim",

    -- orgmode
    "dhruvasagar/vim-table-mode",
    "simrat39/symbols-outline.nvim",
    "nvim-orgmode/orgmode",

    -- python
    "greghor/vim-pyshell",
    "julienr/vim-cellmode",
    "lervag/vimtex",
    "preservim/vimux",
    "shime/vim-livedown",
    "brentyi/isort.vim",

    -- rust
    'rust-lang/rust.vim' ,
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
    -- "vimwiki/vimwiki",
    {
        "andrewferrier/wrapping.nvim",
        config = function()
            require("wrapping").setup()
        end
    }
}

require("lazy").setup(plugins, {})
