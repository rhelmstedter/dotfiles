local keymap = vim.keymap.set
local opts = { noremap = true }
local s_opts = { noremap = true, silent = true }

-- best mapleader ever
vim.g.mapleader = " "

-- escape
keymap("i", "jk", "<esc>", opts)

-- write file
keymap("n", "<leader>w", "<cmd>w<CR>", opts)

-- source lua files
keymap("n", "<leader><leader>l", ":luafile %<cr>", opts)
keymap("n", "<leader><leader>s", ":so %<cr>", opts)

-- move windows
keymap("n", "<leader>h", "<C-w>h", s_opts)
keymap("n", "<leader>j", "<C-w>j", s_opts)
keymap("n", "<leader>k", "<C-w>k", s_opts)
keymap("n", "<leader>l", "<C-w>l", s_opts)

-- change directory to current file
keymap("n", "<leader>cd", ":cd %:p:h<CR>", s_opts)

-- copy to clipboard on mac
keymap("n", "<leader>p", '"+p', s_opts)
keymap("v", "<leader>y", '"+y', s_opts)

-- delete without yanking
keymap("n", "<leader>d", '"_d', s_opts)
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
keymap("n", "<leader>n", ":Ex<CR>", s_opts)
