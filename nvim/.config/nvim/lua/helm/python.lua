vim.g.python3_host_prog = "/opt/homebrew/bin/python3" -- for mac-mini
-- vim.g.python3_host_prog= '/usr/bin/python3' -- for WSL on work comp
-- vim.g.python3_host_prog = "/usr/local/bin/python3" -- for mbp 2015

vim.g.cellmode_use_tmux = 1
vim.g.cellmode_tmux_panenumber = 0
vim.g.VimuxRunnerType = "window"
vim.g.cellmode_tmux_windowname = "iPython"

local keymap = vim.keymap.set
local s_opts = { noremap = true, silent = true }

-- format with Black
keymap("n", "<leader>b", "<cmd>Black<CR>", s_opts)
-- make it an f-string
keymap("n", "<leader>fs", 'maF"if<esc>`al', s_opts)
-- ipython-shell for data science
keymap("n", "<leader>ss", "<cmd> call StartPyShell()<CR>", s_opts)
keymap("n", "<leader>sk", "<cmd> call StopPyShell()<CR>", s_opts)
keymap("n", "<leader>sl", "<cmd> call PyShellSendLine()<CR>", s_opts)
keymap("n", "<leader>rr", "<cmd> call RunTmuxPythonCell(0)<CR>", s_opts)
keymap("n", "<leader>ra", "<cmd> call RunTmuxPythonAllCellsAbove()<CR>", s_opts)
