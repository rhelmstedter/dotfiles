local M = {}
M.theme = function()
    local colors = {
        darkgray = "#979BAC",
        outerbg = "#f5f5f5", -- gray
        white = "#ffffff",
        innerbg = nil,
        cyan = "#489FC1", -- cyan
        midbg = "#a9a1e1", -- violet
        normal = "#c678dd", -- midbg
        insert = "#98be65", -- green
        visual = "#da8548", -- orange
        replace = "#ff6c6b", -- red
        command = "#ECBE7B", -- yellow
    }
    return {
        inactive = {
            a = { fg = colors.midbg, bg = colors.outerbg, gui = "bold" },
            b = { fg = colors.midbg, bg = colors.outerbg },
            c = { fg = colors.midbg, bg = colors.innerbg },
        },
        visual = {
            a = { fg = colors.white, bg = colors.visual, gui = "bold" },
            b = { fg = colors.white, bg = colors.midbg },
            c = { fg = colors.gray, bg = colors.innerbg },

            x = { fg = colors.white, bg = colors.midbg },
            z = { fg = colors.white, bg = colors.visual },
        },
        replace = {
            a = { fg = colors.white, bg = colors.replace, gui = "bold" },
            b = { fg = colors.white, bg = colors.midbg },
            c = { fg = colors.gray, bg = colors.innerbg },

            x = { fg = colors.white, bg = colors.midbg },
            z = { fg = colors.white, bg = colors.replace },
        },
        normal = {
            a = { fg = colors.white, bg = colors.normal, gui = "bold" },
            b = { fg = colors.white, bg = colors.midbg },
            c = { fg = colors.gray, bg = colors.innerbg },

            x = { fg = colors.white, bg = colors.midbg },
            z = { fg = colors.white, bg = colors.normal },
        },
        insert = {
            a = { fg = colors.white, bg = colors.insert, gui = "bold" },
            b = { fg = colors.white, bg = colors.midbg },
            c = { fg = colors.gray, bg = colors.innerbg },

            x = { fg = colors.white, bg = colors.midbg },
            z = { fg = colors.white, bg = colors.insert },
        },
        command = {
            a = { fg = colors.white, bg = colors.command, gui = "bold" },
            b = { fg = colors.white, bg = colors.midbg },
            c = { fg = colors.gray, bg = colors.innerbg },

            x = { fg = colors.white, bg = colors.midbg },
            z = { fg = colors.white, bg = colors.command },
        },
    }
end
return M
