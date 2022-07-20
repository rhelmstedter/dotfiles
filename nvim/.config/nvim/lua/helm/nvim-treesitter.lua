require("nvim-treesitter.configs").setup {
    ensure_installed = { "python", "lua", "bash", "vim", "org" },
    highlight = {
        enable = true,
        -- additional_vim_regex_highlighting = { "org" },
    },
    pyfold = {
        enable = true,
        custom_foldtext = true,
    },
    playground = {
        enabled = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
}
vim.treesitter.highlighter.hl_map.error = nil
