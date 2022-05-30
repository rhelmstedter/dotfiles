-- for WSL on work comp
-- vim.g.python3_host_prog= '/usr/bin/python3'

-- for mac-mini
vim.g.python3_host_prog = "/opt/homebrew/bin/python3"

-- for mbp 2015
-- vim.g.python3_host_prog = "/usr/local/bin/python3"

-- vim cell-mode parameters
vim.g.cellmode_use_tmux = 1
vim.g.cellmode_tmux_panenumber = 0
vim.g.VimuxRunnerType = "window"
vim.g.cellmode_tmux_windowname = "iPython"


local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local format_python = augroup("format_python", { clear = true })
-- autocmd("BufWritePre", {
--     pattern = "*.py",
--     command = "Black",
--     group = format_python,
-- })
autocmd("BufWritePre", {
    pattern = "*.py",
    command = "Isort",
    group = format_python,
})

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Format with Black
keymap("n", "<leader>b", "<cmd>Black<CR>", opts)

-- f-strings
keymap("n", "<leader>fs", 'maF"if<esc>`al', opts)

-- ipython-shell for data science
keymap("n", "<leader>ss", "<cmd> call StartPyShell()<CR>", opts)
keymap("n", "<leader>sk", "<cmd> call StopPyShell()<CR>", opts)
keymap("n", "<leader>sl", "<cmd> call PyShellSendLine()<CR>", opts)
keymap("n", "<leader>rr", "<cmd> call RunTmuxPythonCell(0)<CR>", opts)
keymap("n", "<leader>ra", "<cmd> call RunTmuxPythonAllCellsAbove()<CR>", opts)
