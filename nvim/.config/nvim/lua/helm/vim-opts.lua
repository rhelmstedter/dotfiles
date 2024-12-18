
vim.o.background = "dark"
vim.cmd("colorscheme gruvbox")

local options = {
    backup = false,                                  -- creates a backup file
    cmdheight = 2,                                   -- more space in the neovim command line for displaying messages
    clipboard = "unnamedplus",                        -- allows neovim to access the system clipboard
    colorcolumn = { 120 },                           -- highlight preferred line length
    -- columns = 120,
    completeopt = { "menu", "menuone", "noselect" }, -- need for cmp
    expandtab = true,                                -- convert tabs to spaces
    fileencoding = "utf-8",                          -- the encoding written to a file
    hidden = true,                                   -- required to keep multiple buffers and open multiple buffers
    hlsearch = true,                                 -- highlight all matches on previous search pattern
    ignorecase = true,                               -- ignore case in search patterns
    incsearch = true,                                -- highlight as you search and replace
    inccommand = "split",
    linebreak = true,                                -- don't break midword
    list = true,                                     -- show characters like spaces and tabs
    modifiable = true,
    number = true,                                   -- set numbered lines
    pumheight = 15,                                  -- pop up menu height
    relativenumber = false,                          -- set relative numbered lines
    scrolloff = 8,                                   -- keep cursor off bottom
    shiftwidth = 4,                                  -- the number of spaces inserted for each indentation
    showmode = false,                                -- hide message when not in normal mode
    sidescrolloff = 8,                               -- keep cursor 8 lines off bottom
    signcolumn = "yes",                              -- always show the sign column, otherwise it would shift the text each time
    smartcase = true,                                -- case insensitive search until you include a capital letter
    splitbelow = true,                               -- force all horizontal splits to go below current window
    splitright = true,                               -- force all vertical splits to go to the right of current window
    swapfile = false,                                -- creates a swapfile
    termguicolors = true,                            -- set term gui colors (most terminals support this)
    timeoutlen = 500,                                -- time to wait for a mapped sequence to complete (in milliseconds)
    undodir = vim.fn.stdpath "config" .. "/undodir", -- location of undo files
    undofile = true,                                 -- enable persistent undo
    updatetime = 300,                                -- faster completion (4000ms default)
    wrap = false,                                    -- display lines as one long line
    writebackup = false,                             -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}
vim.opt.shortmess:append "c"
for option, value in pairs(options) do
    vim.opt[option] = value
end

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
    end,
    group = augroup("highlight_yank", { clear = true }),
})
