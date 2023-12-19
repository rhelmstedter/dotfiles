require('hlargs').setup()

-- Add color to cursor
vim.g.doom_one_cursor_coloring = true
-- terminal colors
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
vim.g.doom_one_plugin_nvim_tree = false
vim.g.doom_one_plugin_whichkey = false
vim.g.doom_one_plugin_indent_blankline = false
vim.g.doom_one_plugin_lspsaga = false
vim.g.doom_one_plugin_barbar = false
vim.g.doom_one_plugin_neorg = false
vim.g.doom_one_plugin_telescope = true
vim.g.doom_one_plugin_neogit = false
vim.g.doom_one_plugin_dashboard = false
vim.g.doom_one_plugin_startify = false
vim.g.doom_one_plugin_vim_illuminate = false

vim.cmd([[
colorscheme doom-one
]])
-- require("doom-one").setup {
--     cursor_coloring = false,
--     terminal_colors = true,
--     italic_comments = true,
--     enable_treesitter = true,
--     transparent_background = true,
--     pumblend = {
--         enable = true,
--         transparency_amount = 20,
--     },
--     plugins_integrations = {
--         neorg = false,
--         orgmode = false,
--         barbar = false,
--         bufferline = false,
--         gitgutter = false,
--         gitsigns = true,
--         telescope = true,
--         neogit = false,
--         nvim_tree = false,
--         dashboard = false,
--         startify = false,
--         whichkey = false,
--         indent_blankline = false,
--         cmp = true,
--         vim_illuminate = false,
--         lspsaga = false,
--     },
-- }
--
-- local keymap = vim.keymap.set
-- local s_opts = { noremap = true, silent = true }
--
-- function Dark_mode()
--     require "doom-one".setup()
--     vim.api.nvim_set_option("background", "dark")
--     vim.cmd "colorscheme doom-one"
--     require("doom-one").setup {
--         transparent_background = true,
--     }
--     require("lualine").setup {
--         options = {
--             theme = require("helm/lualine-doom-one").theme(),
--         },
--     }
-- end
--
-- function Light_mode()
--     vim.api.nvim_set_option("background", "light")
--     vim.cmd "colorscheme doom-one"
--     require("doom-one").setup {
--         transparent_background = false,
--     }
--     require("lualine").setup {
--         options = {
--             theme = require("helm/lualine-doom-one-light").theme(),
--         },
--     }
-- end
--
-- keymap("n", "<leader>lm", "<cmd> lua Light_mode()<CR>", s_opts)
-- keymap("n", "<leader>dm",  "<cmd> lua Dark_mode()<CR>", s_opts)
