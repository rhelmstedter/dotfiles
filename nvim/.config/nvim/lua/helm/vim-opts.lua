local options = {
    backup = false, -- creates a backup file
    cmdheight = 2, -- more space in the neovim command line for displaying messages
    completeopt = { "menuone", "noselect" }, -- mostly just for cmp
    expandtab = true, -- convert tabs to spaces
    fileencoding = "utf-8", -- the encoding written to a file
    hidden = true, -- required to keep multiple buffers and open multiple buffers
    hlsearch = true, -- highlight all matches on previous search pattern
    ignorecase = true, -- ignore case in search patterns
    incsearch = true,
    linebreak = true, -- don't break midword
    list = true,
    number = true, -- set numbered lines
    pumheight = 15, -- pop up menu height
    relativenumber = true, -- set relative numbered lines
    scrolloff = 8, -- keep cursor off bottom
    shiftwidth = 4, -- the number of spaces inserted for each indentation
    showcmd = true,
    sidescrolloff = 8,
    signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
    smartcase = true, -- smart case
    smartindent = true, -- make indenting smarter again
    softtabstop = 4,
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window
    swapfile = false, -- creates a swapfile
    tabstop = 4, -- insert 4 spaces for a tab
    termguicolors = true, -- set term gui colors (most terminals support this)
    timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
    undodir = vim.fn.stdpath "config" .. "/undodir",
    undofile = true, -- enable persistent undo
    updatetime = 300, -- faster completion (4000ms default)
    wrap = false, -- display lines as one long line
    writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- Remove banner in netrw
vim.g.netrw_banner = 0

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- highlight yanked region
local highlight_yank = augroup("highlight_yank", { clear = true })

autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank { higroup = "IncSearch", timeout = 300 }
    end,
    group = highlight_yank,
})

-- highlights recommended line length
-- TODO: convert to lua
vim.cmd [[
    augroup columnLenHighlight
          autocmd!
          autocmd FileType python highlight ColorColumn ctermbg=gray guibg=#a9a1e1|call matchadd('ColorColumn', '\%90v', 100)
    augroup END
]]

local tabs = augroup("tabs", { clear = true })

autocmd("FileType", {
    pattern = { "html" },
    command = "set tabstop=2| set shiftwidth=2| set expandtab",
    group = tabs,
})
autocmd("FileType", {
    pattern = { "markdown", "vimwiki" },
    command = "set tabstop=5| set shiftwidth=5| set noexpandtab| set noautoindent",
    group = tabs,
})
autocmd("FileType", {
    pattern = { "python" },
    command = "set tabstop=4| set shiftwidth=4| set expandtab",
    group = tabs,
})
