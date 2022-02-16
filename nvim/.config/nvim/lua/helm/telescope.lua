local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		file_sorter = require("telescope.sorters").get_fzy_sorter,
		prompt_prefix = " >",
		color_devicons = true,

		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

		mappings = {
			i = {
				["<C-x>"] = false,
				["<C-q>"] = actions.send_to_qflist,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
	},
})

require("telescope").load_extension("fzy_native")

local opts = { noremap = true, silent = true }

-- vim.api.nvim_set_keymap("n", "<Leader>p", ":lua require\"helm.telescope\".project_files()<Cr>", opts)
vim.api.nvim_set_keymap("n", "<Leader>df", ':lua require"helm.telescope".search_dotfiles()<Cr>', opts)
vim.api.nvim_set_keymap("n", "<Leader>nc", ':lua require"helm.telescope".search_vimrc()<Cr>', opts)
vim.api.nvim_set_keymap("n", "<Leader>ff", ":Telescope find_files<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>fg", ":Telescope live_grep<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>fb", ":Telescope buffers<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>fh", ":Telescope help_tags<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>fc", ":Telescope command_history<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>fd", ":Telescope diagnostics<CR>", opts)

local M = {}
M.search_dotfiles = function()
	require("telescope.builtin").find_files({
		prompt_title = "< dotfiles >",
		cwd = "~/dotfiles",
		hidden = false,
	})
end

M.search_vimrc = function()
	require("telescope.builtin").find_files({
		prompt_title = "< Nvim Config >",
		cwd = "~/dotfiles/nvim/.config/nvim/",
		hidden = true,
		shorten_path = true,
	})
end

return M
