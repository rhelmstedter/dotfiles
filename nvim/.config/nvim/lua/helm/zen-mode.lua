require("zen-mode").setup({
	window = {
		backdrop = 0.4,
		width = 100,
		height = 0.90,
		options = {
			number = false,
			relativenumber = false,
		},
	},
})

require("twilight").setup({})

local keymap = vim.api.nvim_set_keymap
keymap("n", "<leader>gz", ":ZenMode<CR>", { silent = true })
