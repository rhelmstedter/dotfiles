require("zen-mode").setup {
    window = {
        backdrop = 0.4,
        width = 120,
        height = 1,
        options = {
            number = true,
            relativenumber = true,
        },
    },
}

-- require("twilight").setup {
--     dimming = {
--         alpha = 0.90, -- amount of dimming
--         -- we try to get the foreground from the highlight groups or fallback color
--         color = { "Normal", "#000000" },
--         inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
--     },
--     context = 10, -- amount of lines we will try to show around the current line
--     treesitter = true, -- use treesitter when available for the filetype
--     -- treesitter is used to automatically expand the visible text,
--     -- but you can further control the types of nodes that should always be fully expanded
--     expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
--         "function",
--         "method",
--         "table",
--         "if_statement",
--     },
--     exclude = { "markdown", "vimwiki" }, -- exclude these filetypes
-- }

local keymap = vim.api.nvim_set_keymap
keymap("n", "z", ":ZenMode<CR>", { silent = true })
