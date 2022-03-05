require("orgmode").setup_ts_grammar()

-- Tree-sitter configuration
require("nvim-treesitter.configs").setup {
    -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "org" }, -- Required since TS highlighter doesn't support all syntax features (conceal)
    },
    ensure_installed = { "org" }, -- Or run :TSUpdate org
}

require("org-bullets").setup {
    symbols = { "⁖", "◉", "○", "✸", "✿" },
}

require("orgmode").setup {
    org_agenda_files = { "~/Dropbox/org/*", "~/org-mode/**/*" },
    org_default_notes_file = "~/Dropbox/org/refile.org",
    org_todo_keywords = { "TODO(t)", "WAITING(w)", "|", "DONE", "CANCALLED(c)" },
    org_todo_keyword_faces = {
        WAITING = ":foreground #51afef :weight bold",
        TODO = ":foreground #98be65",
    },
}

vim.cmd [[
    augroup orgSettings
        autocmd!
        autocmd FileType org set concealcursor=nc| set conceallevel=2|set foldmethod=expr |set foldexpr=nvim_treesitter#foldexpr()
    augroup END
]]
