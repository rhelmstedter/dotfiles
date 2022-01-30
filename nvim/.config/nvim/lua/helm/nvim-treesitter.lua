require('nvim-treesitter.configs').setup {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
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
vim.optfoldexpr = "nvim_treesitter#foldexpr()"
