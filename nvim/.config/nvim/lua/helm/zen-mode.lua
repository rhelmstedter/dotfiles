require("zen-mode").setup {
    window = {
        backdrop = 0.4,
        width = 120,
        height = 1,
        options = {
            number = true,
        },
    },
}


local keymap = vim.api.nvim_set_keymap
keymap("n", "z", ":ZenMode<CR>", { silent = true })
