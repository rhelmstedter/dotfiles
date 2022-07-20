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
        orgmode = false,
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

local keymap = vim.keymap.set
local s_opts = { noremap = true, silent = true }

function Dark_mode()
    require "doom-one".setup()
    vim.api.nvim_set_option("background", "dark")
    vim.cmd "colorscheme doom-one"
    require("doom-one").setup {
        transparent_background = true,
    }
    require("lualine").setup {
        options = {
            theme = require("helm/lualine-doom-one").theme(),
        },
    }
end

function Light_mode()
    vim.api.nvim_set_option("background", "light")
    vim.cmd "colorscheme doom-one"
    require("doom-one").setup {
        transparent_background = false,
    }
    require("lualine").setup {
        options = {
            theme = require("helm/lualine-doom-one-light").theme(),
        },
    }
end

keymap("n", "<leader>lm", "<cmd> lua Light_mode()<CR>", s_opts)
keymap("n", "<leader>dm",  "<cmd> lua Dark_mode()<CR>", s_opts)
