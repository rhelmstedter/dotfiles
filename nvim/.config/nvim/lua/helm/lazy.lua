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

    -- lsp
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",

    -- IDE
    "akinsho/toggleterm.nvim",
    "markonm/traces.vim",
    "mhartington/formatter.nvim",
    "numtostr/comment.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    "ThePrimeagen/harpoon",
    "tpope/vim-fugitive",
    "tpope/vim-repeat",
    "kylechui/nvim-surround",
    "jose-elias-alvarez/null-ls.nvim",
    --  "ggandor/lightspeed.nvim",
    "ggandor/leap.nvim",
    --  "kevinhwang91/nvim-ufo",

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
    -- "ntbbloodbath/doom-one.nvim",
    "NTBBloodbath/doom-one.nvim",
    "nvim-lualine/lualine.nvim",
    "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" ,
    --  "nvim-treesitter/nvim-treesitter-context",
    "onsails/lspkind-nvim",

    -- orgmode
    --  "akinsho/org-bullets.nvim",
    "dhruvasagar/vim-table-mode",
    "simrat39/symbols-outline.nvim",
    "nvim-orgmode/orgmode",

    -- python
    --  "eddiebergman/nvim-treesitter-pyfold",
    "greghor/vim-pyshell",
    "julienr/vim-cellmode",
    "lervag/vimtex",
    "preservim/vimux",
    -- "python/black",
    -- { "averms/black-nvim", run = ":UpdateRemotePlugins" },
    "shime/vim-livedown",
    "brentyi/isort.vim",
    "pixelneo/vim-python-docstring",

    -- zettelkasten
    "junegunn/fzf",
    "junegunn/fzf.vim",
    "michal-h21/vim-zettel",
    "preservim/vim-pencil",
    "vimwiki/vimwiki",
}

require("lazy").setup(plugins, {})
