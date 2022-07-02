vim.g.zettel_format = "%Y%m%d%H%M"
vim.g.vimwiki_list = {
    {
        path = "~/Zettelkasten/zettel",
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
-- I prefer telescope, but use this for inserting a note with [[
vim.g.zettel_fzf_command = "rg --column --line-number --smart-case --no-heading --color=always"
-- couldn't get these working in lua
vim.cmd [[
    let g:zettel_options = [{"front_matter": {"tags": "", "citation": ""}}]
]]
vim.cmd [[
    let g:pencil#wrapModeDefault = 'soft'
    let g:pencil#textwidth = 100
]]

local keymap = vim.api.nvim_set_keymap
local s_opts = { noremap = true, silent = true }

-- Nice way to see how markdown will render
keymap("n", "gm", ":LivedownToggle<CR>", s_opts)
-- toggle file type between md and vimwiki filetypes
keymap("n", "<leader>md", ":set filetype=markdown<CR>", s_opts)
keymap("n", "<leader>vw", ":set filetype=vimwiki<CR>", s_opts)
-- open zettelkasten to search notes while working in vim
keymap(
    "n",
    "<leader>zk",
    ":vsplit ~/Zettelkasten/zettel/index.md<cr> :cd %:p:h<cr>",
    s_opts
)
-- Fix last spelling error
keymap("n", "<leader>sc", 'mm[s1z=`m"', s_opts)

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local pencil = augroup("pencil", { clear = true })
local spell_check = augroup("spell_check", { clear = true })
local hide_links = augroup("hide_links", { clear = true })

autocmd("FileType", {
    pattern = { "markdown", "vimwiki" },
    callback = "pencil#init",
    group = pencil,
})
autocmd("FileType", {
    pattern = { "markdown", "vimwiki" },
    command = "set spell",
    group = spell_check,
})
autocmd("FileType", {
    pattern = { "markdown", "vimwiki" },
    command = "set concealcursor=nc |set conceallevel=3",
    group = hide_links,
})

-- This was an attempt to rewrite [[ to work with telescope. I have failed.
-- keymap("i", "[z", '<cmd>lua require("helm.zettelkasten").test_grep_filename()<CR>', opts)
-- local M = {}
-- function M.mysplit(inputstr, sep)
--     if sep == nil then
--         sep = "%s"
--     end
--     local t = {}
--     for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
--         table.insert(t, str)
--     end
--     return t
-- end
-- function M.test_grep_filename()
--     local zettel_opts = {
--         prompt_title = "~ Insert Zettel ~",
--         shorten_path = false,
--         cwd = "~/Zettelkasten/zettel/",
--         attach_mappings = function(_, map)
--             map("i", "<CR>", function(prompt_bufnr)
--                 -- filename is available at entry[1]
--                 local entry = require("telescope.actions.state").get_selected_entry()
--                 require("telescope.actions").close(prompt_bufnr)
--                 local filename = M.mysplit(entry[1], ':')[1]
--                 vim.cmd("normal i" .. filename)
--             end)
--             return true
--         end,
--     }
--     require("telescope.builtin").live_grep(zettel_opts)
-- end
-- return M
