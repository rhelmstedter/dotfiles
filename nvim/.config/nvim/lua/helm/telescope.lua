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
local builtin = require "telescope.builtin"

keymap("n", "<Leader>ff", builtin.find_files, opts)
keymap("n", "<Leader>fg", builtin.live_grep, opts)
keymap("n", "<Leader>fb", builtin.buffers, opts)
keymap("n", "<Leader>fc", builtin.command_history, opts)
keymap("n", "<Leader>fd", builtin.diagnostics, opts)
keymap("n", "<C-p>", builtin.git_files, opts)
keymap("n", "<Leader>fh", function()
    builtin.help_tags(require("telescope.themes").get_dropdown { previewer = false })
end, opts)
keymap("n", "<leader>ps", function()
    builtin.grep_string { search = vim.fn.input "Grep > " }
end, opts)
keymap("n", "<Leader>nc", function()
    require'helm.telescope'.search_vimrc()
end, opts)

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
