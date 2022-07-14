local status_ok = pcall(require, "Comment")
if not status_ok then
	return
end
require("Comment").setup({})

require("nvim-surround").setup({})

require("nvim-surround").buffer_setup({
    delimiters = {
        pairs = {
            ["l"] = function()
                return {
                    "[",
                    "](" .. vim.fn.getreg("+") .. ")",
                }
            end,
        },
    },
})
