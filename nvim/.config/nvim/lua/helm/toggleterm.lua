local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
    return
end

toggleterm.setup {
    size = 120,
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
}

function _G.set_terminal_keymaps()
    local opts = { noremap = true }
    local buf_keymap = vim.api.nvim_buf_set_keymap
    buf_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
    buf_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
end

vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"

local Terminal = require("toggleterm.terminal").Terminal
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

local lazygit = Terminal:new {
    cmd = "lazygit",
    hidden = true,
}
local python = Terminal:new {
    cmd = "python3",
    hidden = true,
}
local pytest = Terminal:new {
    dir = vim.fn.expand "%:p:h",
    cmd = "python3 -m pytest -svv",
    hidden = true,
    direction = "vertical",
}
local run_python_file = Terminal:new {
    cmd = "python3 " .. vim.fn.expand "%",
    hidden = true,
}
local debug_python_file = Terminal:new {
    cmd = "python3 -m pdb " .. vim.fn.expand "%",
    hidden = true,
}

function _LAZYGIT_TOGGLE()
    lazygit:toggle()
end

function _PYTHON_TOGGLE()
    python:toggle()
end

function _PYTEST_TOGGLE()
    pytest:toggle()
end

function _RUN_PYTHON_FILE_TOGGLE()
    run_python_file:toggle()
end

function _DEBUG_PYTHON_FILE_TOGGLE()
    debug_python_file:toggle()
end

keymap("n", "<F5>", "<cmd>w<CR><cmd>lua _DEBUG_PYTHON_FILE_TOGGLE()<CR>", opts)
keymap("n", "<F9>", "<cmd>w<CR><cmd>lua _RUN_PYTHON_FILE_TOGGLE()<CR>", opts)
keymap("n", "<c-t>", "<cmd>w<CR><cmd>lua _PYTEST_TOGGLE()<CR>", opts)
keymap("n", "<C-p>", "<cmd>lua _PYTHON_TOGGLE()<CR>", opts)
keymap("n", "<C-g>", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)
