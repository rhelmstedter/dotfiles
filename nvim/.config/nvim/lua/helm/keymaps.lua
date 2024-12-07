local keymap = vim.keymap.set
local opts = { noremap = true }
local s_opts = { silent = true }

vim.g.mapleader = " "

-- keymap is a function: keymap(mode, keys, action, options)

-- escape
keymap("i", "jk", "<esc>", s_opts)
-- write file
keymap("n", "<leader>bs", "<cmd>w<CR>", opts)
-- source files
keymap("n", "<leader><leader>l", "<cmd>luafile %<cr>", opts)
keymap("n", "<leader><leader>x", "<cmd>source %<cr>", opts)
keymap("n", "<leader>x", "<cmd>.lua <cr>", opts)
-- move between windows (splits)
keymap("n", "<leader>wh", "<C-w>h", s_opts)
keymap("n", "<leader>wj", "<C-w>j", s_opts)
keymap("n", "<leader>wk", "<C-w>k", s_opts)
keymap("n", "<leader>wl", "<C-w>l", s_opts)
-- move between buffers
keymap("n", "<leader>bn", ":bnext<CR>", s_opts)
keymap("n", "<leader>bp", ":bprev<CR>", s_opts)
keymap("n", "<leader>bi", ":ls<CR>", s_opts)
-- change directory to current file
keymap("n", "<leader>cd", ":cd %:p:h<CR>", s_opts)
-- copy to clipboard
keymap("n", "<leader>p", '"+p', s_opts)
keymap("v", "<leader>y", '"+y', s_opts)
-- delete without yanking
keymap("v", "<leader>d", '"_d', s_opts)
-- clear search highlighting
keymap("n", "<esc>", ":noh<return><esc>", s_opts)
keymap("i", "<esc>", "<esc>:noh<return><esc>", s_opts)
-- center searches
keymap("n", "n", "nzzzv", s_opts)
keymap("n", "N", "Nzzzv", s_opts)
-- move visual lines
keymap("v", "J", ":m '>+1<CR>gv=gv", s_opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", s_opts)
-- open html file
keymap("n", "<leader>o", ":w<CR>:!open " .. vim.fn.expand "%" .. "<CR>", s_opts)
-- Explore File
keymap("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
-- Codeium Chat
keymap("n", "<leader>cc", "<CMD>Codeium Chat<CR>", { desc = "Codeium Chat" })

