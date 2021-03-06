-- local pickers = require "telescope.pickers"
-- local finders = require "telescope.finders"
-- local previewers = require "telescope.previewers"
-- local action_state = require "telescope.actions.state"
-- local conf = require("telescope.config").values

local actions = require "telescope.actions"
require("telescope").load_extension "fzy_native"
require("telescope").setup {
    defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        prompt_prefix = " >",
        color_devicons = true,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
        },
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    },
}

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
local help_tags_layout = "<cmd>lua require'telescope.builtin'.help_tags(require('telescope.themes').get_dropdown({ previewer = false }))<cr>"

keymap("n", "<Leader>nc", "<cmd>lua require'helm.telescope'.search_vimrc()<Cr>", opts)
keymap("n", "<Leader>ff", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<Leader>fg", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<Leader>fb", "<cmd>Telescope buffers<CR>", opts)
keymap("n", "<Leader>fh", help_tags_layout, opts)
keymap("n", "<Leader>fc", "<cmd>Telescope command_history<CR>", opts)
keymap("n", "<Leader>fd", "<cmd>Telescope diagnostics<CR>", opts)

local themes = require "telescope.themes"
local should_reload = true
local reloader = function()
    if should_reload then
        require("plenary.reload").reload_module("helm/telescope")
    end
end

local M = {}
function M.search_vimrc()
    reloader()
    local ff_opts = themes.get_dropdown {
        prompt_title = "<Nvim Config>",
        cwd = "~/dotfiles/nvim/.config/nvim/",
        hidden = true,
        shorten_path = true,
        height = 20,
        previewer = false,
    }
    require("telescope.builtin").find_files(ff_opts)
end
return M
