

require("doom-one").setup {
    cursor_coloring = false,
    terminal_colors = true,
    italic_comments = true,
    enable_treesitter = true,
    transparent_background = true,
    pumblend = {
        enable = true,
        transparency_amount = 20,
    },
    plugins_integrations = {
        neorg = false,
        barbar = false,
        bufferline = false,
        gitgutter = false,
        gitsigns = true,
        telescope = true,
        neogit = false,
        nvim_tree = false,
        dashboard = false,
        startify = false,
        whichkey = false,
        indent_blankline = false,
        cmp = true,
        vim_illuminate = false,
        lspsaga = false,
    },
}

-- Change theme based on time of day
-- Winter sunset at 5pm Summer sunset at 8pm
-- local sunrise = 7
-- local sunset = 8
--
-- vim.g.dusk_til_dawn_light_theme = 'doom-one'
-- vim.g.dusk_til_dawn_dark_theme = 'doom-one'
-- vim.g.dusk_til_dawn_dawn = sunrise
-- vim.g.dusk_til_dawn_night = sunset
--
-- require("Dusk-til-Dawn").timeMan()()
-- vim.cmd('colorscheme doom-one')

-- local auto_dark_mode = require "auto-dark-mode"
--
-- auto_dark_mode.setup {
--     update_interval = 1000,
--     set_dark_mode = function()
--         vim.api.nvim_set_option("background", "dark")
--         vim.cmd "colorscheme doom-one"
--     end,
--     set_light_mode = function()
--         vim.api.nvim_set_option("background", "light")
--         vim.cmd "colorscheme doom-one"
--     end,
-- }
--
-- auto_dark_mode.init()
