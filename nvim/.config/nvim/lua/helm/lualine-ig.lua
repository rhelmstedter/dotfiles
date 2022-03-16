local M = {}
M.theme = function()
    local colors = {
      darkgray = '#979BAC',
      outerbg = '#f5f5f5', -- gray
      white = '#ffffff',
      innerbg = '#f5f5f5', -- gray
      cyan = '#489FC1', -- cyan
      black = '#383a42',
      normal = '#ca1243', -- red
      command = '#8ec07c', -- green
      visual = '#fe8019', -- orange
      insert = '#83a598', -- light-green
      replace = '#f8eec7', -- yellow
    }
    return {
        inactive = {
            a = { fg = colors.black, bg = colors.outerbg, gui = "bold" },
            b = { fg = colors.black, bg = colors.outerbg },
            c = { fg = colors.black, bg = colors.innerbg },
        },
        visual = {
            a = { fg = colors.white, bg = colors.visual, gui = "bold" },
            b = { fg = colors.white, bg = colors.black },
            c = { fg = colors.gray, bg = colors.innerbg },

            x = { fg = colors.white, bg = colors.black },
            z = { fg = colors.white, bg = colors.visual },
        },
        replace = {
            a = { fg = colors.black, bg = colors.replace, gui = "bold" },
            b = { fg = colors.white, bg = colors.outerbg },
            c = { fg = colors.gray, bg = colors.innerbg },

            x = { fg = colors.white, bg = colors.black },
            z = { fg = colors.white, bg = colors.replace },

        },
        normal = {
            a = { fg = colors.white, bg = colors.normal, gui = "bold" },
            b = { fg = colors.white, bg = colors.black },
            c = { fg = colors.gray, bg = colors.innerbg },

            x = { fg = colors.white, bg = colors.black },
            z = { fg = colors.white, bg = colors.normal },
        },
        insert = {
            a = { fg = colors.white, bg = colors.insert, gui = "bold" },
            b = { fg = colors.white, bg = colors.black },
            c = { fg = colors.gray, bg = colors.innerbg },

            x = { fg = colors.white, bg = colors.black },
            z = { fg = colors.white, bg = colors.insert },
        },
        command = {
            a = { fg = colors.black, bg = colors.command, gui = "bold" },
            b = { fg = colors.white, bg = colors.black },
            c = { fg = colors.gray, bg = colors.innerbg },

            x = { fg = colors.white, bg = colors.black },
            z = { fg = colors.black, bg = colors.command },
        },
    }
end
return M
