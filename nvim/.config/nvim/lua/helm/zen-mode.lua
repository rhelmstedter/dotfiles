require("zen-mode").setup {
    window = {
        backdrop = 1,
        width = 120,
        height = 1,
        options = {
            number = true,
        },
    },
}

local keymap = vim.keymap.set
keymap("n", "<leader>z", ":ZenMode<CR>", { silent = true })
