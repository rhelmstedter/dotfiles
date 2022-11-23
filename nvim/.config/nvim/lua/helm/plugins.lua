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
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }


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
    use {
        "NTBBloodbath/doom-one.nvim",
        setup = function()
            -- Add color to cursor
            vim.g.doom_one_cursor_coloring = true
            -- Set :terminal colors
            vim.g.doom_one_terminal_colors = true
            -- Enable italic comments
            vim.g.doom_one_italic_comments = true
            -- Enable TS support
            vim.g.doom_one_enable_treesitter = true
            -- Color whole diagnostic text or only underline
            vim.g.doom_one_diagnostics_text_color = false
            -- Enable transparent background
            vim.g.doom_one_transparent_background = false

            -- Pumblend transparency
            vim.g.doom_one_pumblend_enable = false
            vim.g.doom_one_pumblend_transparency = 20

            -- Plugins integration
            vim.g.doom_one_plugin_neorg = false
            vim.g.doom_one_plugin_barbar = false
            vim.g.doom_one_plugin_telescope = true
            vim.g.doom_one_plugin_neogit = true
            vim.g.doom_one_plugin_nvim_tree = true
            vim.g.doom_one_plugin_dashboard = true
            vim.g.doom_one_plugin_startify = true
            vim.g.doom_one_plugin_whichkey = true
            vim.g.doom_one_plugin_indent_blankline = true
            vim.g.doom_one_plugin_vim_illuminate = true
            vim.g.doom_one_plugin_lspsaga = false
        end,
        config = function()
            vim.cmd "colorscheme doom-one"
        end,
    }
    use "nvim-lualine/lualine.nvim"
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    use "nvim-treesitter/nvim-treesitter-context"
    use "onsails/lspkind-nvim"

    -- orgmode
    use "akinsho/org-bullets.nvim"
    use "dhruvasagar/vim-table-mode"
    use "simrat39/symbols-outline.nvim"
    use "nvim-orgmode/orgmode"

    -- python
    use "eddiebergman/nvim-treesitter-pyfold"
    use "greghor/vim-pyshell"
    use "julienr/vim-cellmode"
    use "lervag/vimtex"
    use "preservim/vimux"
    use "python/black"
    use "shime/vim-livedown"
    use { "stsewd/isort.nvim", run = ":UpdateRemotePlugins" }
    use "pixelneo/vim-python-docstring"

    -- zettelkasten
    use "junegunn/fzf"
    use "junegunn/fzf.vim"
    use "michal-h21/vim-zettel"
    use "preservim/vim-pencil"
    use "vimwiki/vimwiki"
end)
