require("formatter").setup {
    filetype = {
        lua = {
            function()
                return {
                    exe = "stylua",
                    args = {
                        "--config-path " .. "/Users/russell/.config/stylua/stylua.toml",
                        "-",
                    },
                    stdin = true,
                }
            end,
        },
    },
}

local keymap = vim.api.nvim_set_keymap

local opts = { noremap = true, silent = true }

keymap("n", "<leader>fl", "<cmd>Format<CR>", opts)
