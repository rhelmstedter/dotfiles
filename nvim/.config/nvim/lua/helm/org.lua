require("orgmode").setup_ts_grammar()

-- require("org-bullets").setup {
--     symbols = {
--         headlines = { "⁖", "◉", "○", "✸", "✿" },
--         checkboxes = {
--             cancelled = { "", "OrgCancelled" },
--             done = { "✓", "OrgDone" },
--             todo = { "˟", "OrgTODO" },
--         },
--     },
-- }

require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {'org'}, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
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

-- local augroup = vim.api.nvim_create_augroup
-- local autocmd = vim.api.nvim_create_autocmd
-- local org_settings = augroup("org_settings", { clear = true })
--
-- autocmd("Filetype", {
--     pattern = "org",
--     command = "set concealcursor=nc",
--     group = org_settings,
-- })
-- autocmd("Filetype", {
--     pattern = "org",
--     command = "set conceallevel=3",
--     group = org_settings,
-- })
-- autocmd("Filetype", {
--     pattern = "org",
--     command = "set foldmethod=expr",
--     group = org_settings,
-- })
