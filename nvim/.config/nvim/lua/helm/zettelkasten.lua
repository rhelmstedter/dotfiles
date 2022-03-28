vim.g.zettel_format = "%Y%m%d%H%M"

vim.g.vimwiki_list = {
    {
        path = "~/Zettelkasten",
        syntax = "markdown",
        ext = ".md",
    },
    {
        path = "~/Coding-in-Math-Class",
        syntax = "markdown",
        ext = ".md",
    },
    {
        path = "~/coding-class",
        syntax = "markdown",
        ext = ".md",
    },
}

vim.g.nv_search_paths = "~/Zettelkasten"
vim.g.vimwiki_markdown_link_ext = 1
vim.g.vimwiki_global_ext = 0
vim.g.markdown_fenced_languages = { "html", "python", "ruby", "vim", "lua" }
vim.g.vimwiki_ext2syntax = {
    [".md"] = "markdown",
    [".markdown"] = "markdown",
    [".mdown"] = "markdown",
}

-- couldn't get this working in lua
vim.cmd [[
    let g:zettel_options = [{"front_matter": {"tags": "", "citation": ""}}]
]]

-- I prefer telescope, but use this for inserting a note with [[
vim.g.zettel_fzf_command =
    "rg --column --line-number --smart-case --no-heading --color=always"

-- pencil settings
vim.cmd [[
    let g:pencil#wrapModeDefault = 'soft'
    let g:pencil#textwidth = 90
]]

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Nice way to see how markdown will render
keymap("n", "gm", ":LivedownToggle<CR>", opts)

-- toggle file type between md and vimwiki filetypes
keymap("n", "<leader>md", ":set filetype=markdown<CR>", opts)
keymap("n", "<leader>vw", ":set filetype=vimwiki<CR>", opts)

-- open zettelkasten to search notes while working in vim
keymap(
    "n",
    "<leader>zk",
    ":vsplit ~/Zettelkasten/zettel/index.md<cr> :cd %:p:h<cr>",
    opts
)

-- FixLastSpellingError
keymap("n", "<leader>sc", 'mm[s1z=`m"', opts)

-- copy filename
keymap("n", "<leader>yf", '<cmd> let @+ = expand("%:t")<CR>', opts)


-- Zettelkasten Specific Autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local pencil = augroup("pencil", { clear = true })
autocmd("FileType", {
    pattern = { "markdown", "vimwiki" },
    callback = "pencil#init",
    group = pencil,
})
local spell_check = augroup("spell_check", { clear = true })
autocmd("FileType", {
    pattern = { "markdown", "vimwiki" },
    command = "set spell",
    group = spell_check,
})
autocmd("BufLeave", {
    pattern = { "*.md" },
    command = "set nospell",
    group = spell_check,
})

local hide_links = augroup("hide_links", { clear = true })
autocmd("FileType", {
    pattern = { "markdown", "vimwiki" },
    command = "set concealcursor=nc |set conceallevel=3",
    group = hide_links,
})
