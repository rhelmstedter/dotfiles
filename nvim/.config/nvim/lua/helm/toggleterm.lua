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

local Terminal = require("toggleterm.terminal").Terminal
local keymap = vim.keymap.set
local opts = { silent = true }
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
    dir = vim.fn.expand "%:p:h",
    cmd = "python3 " .. vim.fn.expand("%"),
    hidden = false,
}
local debug_python_file = Terminal:new {
    dir = vim.fn.expand "%:p:h",
    cmd = "python3 -m pdb " .. vim.fn.expand("%"),
    hidden = true,
}

-- vim.keymap.set('n', '<c-f>', function () return ':e ' ..  vim.fn.expand '%:p:h' .. '/' end, { expr = true })
keymap("n", "<F5>",  function () return debug_python_file:toggle() end, opts)
keymap("n", "<F9>", function () return run_python_file:toggle() end, opts)
keymap("n", "<c-t>", function () return pytest:toggle() end, opts)
keymap("n", "<C-p>",  function () return python:toggle() end, opts)
keymap("t", "<esc>", [[<C-\><C-n>]], opts)
