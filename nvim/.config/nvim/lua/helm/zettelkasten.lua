vim.g.zettel_format = "%Y%m%d%H%M"
vim.g.vimwiki_list = {
    {
        path = "~/Zettelkasten/zettel",
        syntax = "markdown",
        ext = ".md",
    },
    {
        path = "~/coding-in-math-class",
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
vim.g.vimwiki_ext2syntax = {
    [".md"] = "markdown",
    [".markdown"] = "markdown",
    [".mdown"] = "markdown",
}
-- I prefer telescope, but use this for inserting a note with [[
vim.g.zettel_fzf_command =
    "rg --column --line-number --smart-case --no-heading --color=always"
-- couldn't get these working in lua
vim.cmd [[
    let g:zettel_options = [{"front_matter": {"tags": "", "citation": ""}}]
]]
vim.g.vimwiki_markdown_link_ext = 1
vim.g.vimwiki_global_ext = 0
vim.g.markdown_fenced_languages = { "html", "python", "ruby", "vim", "lua" }
vim.cmd [[
    let g:pencil#wrapModeDefault = 'soft'
    let g:pencil#textwidth = 120
]]
local keymap = vim.keymap.set
local s_opts = { noremap = true, silent = true }
--
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
local zettelkasten = augroup("zettelkasten", { clear = true })

autocmd("FileType", {
    pattern = {"markdown"},
    callback = "pencil#init",
    group = zettelkasten,
})
autocmd("FileType", {
    pattern = { "markdown"},
    command = "setlocal spell",
    group = zettelkasten,
})
autocmd("FileType", {
    pattern = { "markdown"},
    command = "setlocal concealcursor=nc |setlocal conceallevel=3",
    group = zettelkasten,
})

keymap(
    "n",
    "<Leader>fz",
    "<cmd>lua require'helm.zettelkasten'.search_vimrc()<Cr>",
    s_opts
)
local themes = require "telescope.themes"
local should_reload = true
local reloader = function()
    if should_reload then
        require("plenary.reload").reload_module "helm/telescope"
    end
end

local M = {}
function M.search_vimrc()
    reloader()
    vim.cmd [[autocmd User TelescopePreviewerLoaded setlocal wrap]]
    local zettel_opts = themes.get_ivy {
        prompt_title = "<Zettel Search>",
        cwd = "~/Zettelkasten/zettel",
        hidden = true,
        shorten_path = true,
        height = 0.8,
        -- previewer = true,
    }
    require("telescope.builtin").live_grep(zettel_opts)
end

return M
-- -- This was an attempt to rewrite [[ to work with telescope. I have failed.
-- -- keymap("i", "[z", '<cmd>lua require("helm.zettelkasten").test_grep_filename()<CR>', opts)
-- -- local M = {}
-- -- function M.mysplit(inputstr, sep)
-- --     if sep == nil then
-- --         sep = "%s"
-- --     end
-- --     local t = {}
-- --     for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
-- --         table.insert(t, str)
-- --     end
-- --     return t
-- -- end
-- -- function M.test_grep_filename()
-- --     local zettel_opts = {
-- --         prompt_title = "~ Insert Zettel ~",
-- --         shorten_path = false,
-- --         cwd = "~/Zettelkasten/zettel/",
-- --         attach_mappings = function(_, map)
-- --             map("i", "<CR>", function(prompt_bufnr)
-- --                 -- filename is available at entry[1]
-- --                 local entry = require("telescope.actions.state").get_selected_entry()
-- --                 require("telescope.actions").close(prompt_bufnr)
-- --                 local filename = M.mysplit(entry[1], ':')[1]
-- --                 vim.cmd("normal i" .. filename)
-- --             end)
-- --             return true
-- --         end,
-- --     }
-- --     require("telescope.builtin").live_grep(zettel_opts)
-- -- end
-- -- return M
