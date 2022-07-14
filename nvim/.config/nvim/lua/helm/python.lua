local keymap = vim.keymap.set
local s_opts = { silent = true }

----------------------------------
-- set python location for nvim --
----------------------------------

vim.g.python3_host_prog = "/opt/homebrew/bin/python3" -- for mac-mini
-- vim.g.python3_host_prog= '/usr/bin/python3' -- for WSL on work comp
-- vim.g.python3_host_prog = "/usr/local/bin/python3" -- for mbp 2015


-- format with Black
keymap("n", "<leader>b", "<cmd>Black<CR>", s_opts)
-- make it an f-string
keymap("n", "<leader>fs", 'maF"if<esc>`al', s_opts)

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

-----------------------------------
-- python in a floating terminal --
-----------------------------------

local Terminal = require 'toggleterm.terminal'.Terminal
local python_debugger
local python_file_runner
local python = Terminal:new {
    cmd = "python3",
    hidden = true,
}

keymap("n", "<C-p>",  function () return python:toggle() end, s_opts)
keymap('n', '<F5>', function()
    if python_debugger == nil then
        local e = vim.fn.expand

        local errmsg
        if vim.bo.buftype ~= '' then
            errmsg = 'Can\'t run python debugger on terminal'
        elseif e '%' == '' then
            errmsg = 'Can\'t run python debugger on unnamed file'
        end

        if errmsg ~= nil then
            vim.notify(errmsg, vim.log.levels.WARN, { title = 'toggleterm' })
            return
        end

        python_debugger = Terminal:new {
            dir = e '%:p:h',
            cmd = 'python3 -m pdb ' .. e '%',
            hidden = true,
            on_exit = function() python_debugger = nil end,
        }
    end

    python_debugger:toggle()
end)
keymap('n', '<F9>', function()
    if python_file_runner == nil then
        local e = vim.fn.expand

        local errmsg
        if vim.bo.buftype ~= '' then
            errmsg = 'Can\'t run python file on terminal'
        elseif e '%' == '' then
            errmsg = 'Can\'t run python on unnamed file'
        end

        if errmsg ~= nil then
            vim.notify(errmsg, vim.log.levels.WARN, { title = 'toggleterm' })
            return
        end

        python_file_runner = Terminal:new {
            dir = e '%:p:h',
            cmd = 'python3 ' .. e '%',
            hidden = true,
            on_exit = function() python_file_runner = nil end,
        }
    end

    python_file_runner:toggle()
end)
local pytest = Terminal:new {
    dir = vim.fn.expand "%:p:h",
    cmd = "python3 -m pytest -svv",
    hidden = true,
    direction = "vertical",
}
keymap("n", "<c-t>", function () return pytest:toggle() end, s_opts)
