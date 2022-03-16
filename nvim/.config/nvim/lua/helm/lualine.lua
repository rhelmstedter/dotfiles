require("lualine").setup {
    options = {
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = {},
        disabled_filetypes = {},
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },

        lualine_x = { "fileformat", { "filetype", icon_only = true } },
        lualine_y = {},
        lualine_z = { "location", "progress" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = { "toggleterm" },
}
