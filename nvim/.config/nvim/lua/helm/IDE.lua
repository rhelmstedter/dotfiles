require("Comment").setup({})

require("nvim-surround").setup({})

require("nvim-surround").buffer_setup({
    delimiters = {
        pairs = {
            ["l"] = function() -- surrounds visually selected text with a markdown link
                return {
                    "[",
                    "](" .. vim.fn.getreg("+") .. ")",
                }
            end,
        },
    },
})
