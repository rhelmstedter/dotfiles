local keymap = vim.keymap.set
local s_opts = { silent = true }

----------------------------------
-- set python location for nvim --
----------------------------------

-- vim.g.python3_host_prog = "/Users/russell/.pyenv/shims/python3" -- for mac-mini
vim.g.python3_host_prog = "/Users/russell/coding-class/coding-projects/.venv/bin/python3" -- for turtle
-- vim.g.python3_host_prog= '/usr/bin/python3' -- for WSL on work comp
-- vim.g.python3_host_prog = "/usr/local/bin/python3" -- for mbp 2015

---------------------
-- format niceties --
---------------------

-- format code
vim.g.isort_command = "isort"
keymap("n", "<leader>b", "<cmd>Black<CR>", s_opts)
keymap("n", "<leader>i", "<cmd>Isort<CR>", s_opts)
-- make it an f-string
-- keymap("n", "<leader>fs", 'maF"if<esc>`al', s_opts)
--docstrings
-- vim.g.python_style = "rest"

------------------------------------
-- ipython-shell for data science --
------------------------------------

vim.g.cellmode_use_tmux = 1
vim.g.cellmode_tmux_panenumber = 0
vim.g.VimuxRunnerType = "window"
vim.g.cellmode_tmux_windowname = "iPython"
keymap("n", "<leader>ss", "<cmd> call StartPyShell()<CR>", s_opts)
keymap("n", "<leader>sk", "<cmd> call StopPyShell()<CR>", s_opts)
keymap("n", "<leader>sl", "<cmd> call PyShellSendLine()<CR>", s_opts)
keymap("n", "<leader>rr", "<cmd> call RunTmuxPythonCell(0)<CR>", s_opts)
keymap("n", "<leader>ra", "<cmd> call RunTmuxPythonAllCellsAbove()<CR>", s_opts)

---------------------------------------
-- run python in a floating terminal --
---------------------------------------

local Terminal = require("toggleterm.terminal").Terminal
local python_debugger
local python_file_runner
local python = Terminal:new {
    cmd = "python3",
    hidden = true,
}
-- fresh REPL
keymap("n", "<C-p>", function()
    return python:toggle()
end, s_opts)
-- current file with a debugger
keymap("n", "<F5>", function()
    if python_debugger == nil then
        local expand = vim.fn.expand
        local errmsg

        vim.api.nvim_command('write')
        if vim.bo.buftype ~= "" then
            errmsg = "Can't run python debugger on terminal"
        elseif expand("%")== "" then
            errmsg = "Can't run python debugger on unnamed file"
        end

        if errmsg ~= nil then
            vim.notify(errmsg, vim.log.levels.WARN, { title = "toggleterm" })
            return
        end

        python_debugger = Terminal:new {
            dir = expand("%:p:h"),
            cmd = "python3 -m pdb " .. expand("%"),
            hidden = true,
            on_exit = function()
                python_debugger = nil
            end,
        }
    end

    python_debugger:toggle()
end)
-- current file
keymap("n", "<F9>", function()
    if python_file_runner == nil then
        local expand = vim.fn.expand
        local errmsg

        vim.api.nvim_command('write')
        if vim.bo.buftype ~= "" then
            errmsg = "Can't run python file on terminal"
        elseif expand("%") == "" then
            errmsg = "Can't run python on unnamed file"
        end

        if errmsg ~= nil then
            vim.notify(errmsg, vim.log.levels.WARN, { title = "toggleterm" })
            return
        end

        python_file_runner = Terminal:new {
            dir = expand("%:p:h"),
            cmd = "python3 " .. expand("%"),
            hidden = true,
            on_exit = function()
                python_file_runner = nil
            end,
        }
    end

    python_file_runner:toggle()
end)

keymap("n", "<C-t>", function()
    if pytest_runner == nil then
        local expand = vim.fn.expand
        local errmsg

        vim.api.nvim_command('write')
        if vim.bo.buftype ~= "" then
            errmsg = "Can't run python file on terminal"
        elseif expand("%") == "" then
            errmsg = "Can't run python on unnamed file"
        end

        if errmsg ~= nil then
            vim.notify(errmsg, vim.log.levels.WARN, { title = "toggleterm" })
            return
        end

        pytest_runner = Terminal:new {
            dir = expand("%:p:h"),
            cmd = "python3 -m pytest",
            hidden = true,
            direction = "vertical",
            on_exit = function()
                pytest_runner = nil
            end,
        }
    end

    pytest_runner:toggle()
end)

keymap("n", "<leader>pt", function()
    if pytest_runner == nil then
        local expand = vim.fn.expand
        local errmsg

        vim.api.nvim_command('write')
        if vim.bo.buftype ~= "" then
            errmsg = "Can't run python file on terminal"
        elseif expand("%") == "" then
            errmsg = "Can't run python on unnamed file"
        end

        if errmsg ~= nil then
            vim.notify(errmsg, vim.log.levels.WARN, { title = "toggleterm" })
            return
        end

        pytest_runner = Terminal:new {
            dir = vim.fn.getcwd(),
            cmd = "poetry run pytest",
            hidden = true,
            direction = "vertical",
            on_exit = function()
                pytest_runner = nil
            end,
        }
    end

    pytest_runner:toggle()
end)
