local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	size = 20,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = false,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
	-- vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
	-- vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
	-- vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
	-- vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end

keymap("n", "<C-g>", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

local python = Terminal:new({ cmd = "python3", hidden = true })
function _PYTHON_TOGGLE()
	python:toggle()
end
keymap("n", "<C-p>", "<cmd>lua _PYTHON_TOGGLE()<CR>", opts)

local pytest = Terminal:new({ cmd = "python3 -m pytest -svv", hidden = true })
function _PYTEST_TOGGLE()
	pytest:toggle()
end
keymap("n", "<c-t>", "<cmd>w<CR><cmd>lua _PYTEST_TOGGLE()<CR>", opts)

local runpythonfile = Terminal:new({ cmd = "python3 "..vim.fn.expand("%"), hidden = true })
function _RUNPYTHONFILE_TOGGLE()
	runpythonfile:toggle()
end
keymap("n", "<F9>", "<cmd>w<CR><cmd>lua _RUNPYTHONFILE_TOGGLE()<CR>", opts)
