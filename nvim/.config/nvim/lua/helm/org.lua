require("orgmode").setup_ts_grammar()

-- -- Tree-sitter configuration
-- require("nvim-treesitter.configs").setup {
--     highlight = {
--         enable = true,
--         additional_vim_regex_highlighting = { "org" }, -- Required since TS highlighter doesn't support all syntax features (conceal)
--     },
--     ensure_installed = { "org" },
-- }

require("org-bullets").setup {
    symbols = {
        headlines = { "⁖", "◉", "○", "✸", "✿" },
        checkboxes = {
            cancelled = { "", "OrgCancelled" },
            done = { "✓", "OrgDone" },
            todo = { "˟", "OrgTODO" },
        },
    },
}

require("orgmode").setup {
    org_agenda_files = { "~/Dropbox/org/*" },
    org_default_notes_file = "~/Dropbox/org/refile.org",
    org_todo_keywords = { "TODO(t)", "WAITING(w)", "|", "DONE", "CANCALLED(c)" },
    org_todo_keyword_faces = {
        WAITING = ":foreground #51afef :weight bold",
        TODO = ":foreground #98be65",
    },
}

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local org_settings = augroup("org_settings", { clear = true })
autocmd("Filetype", {
    pattern = "org",
    command = "set concealcursor=nc",
    group = org_settings,
})
autocmd("Filetype", {
    pattern = "org",
    command = "set conceallevel=3",
    group = org_settings,
})
autocmd("Filetype", {
    pattern = "org",
    command = "set foldmethod=expr",
    group = org_settings,
})
