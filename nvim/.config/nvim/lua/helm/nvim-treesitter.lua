require("nvim-treesitter.configs").setup {
    ensure_installed = { "python", "lua", "bash", "vim"},
    highlight = {
        enable = true,
    },
    pyfold = {
        enable = false,
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
-- vim.treesitter.highlighter.hl_map.error = nil
