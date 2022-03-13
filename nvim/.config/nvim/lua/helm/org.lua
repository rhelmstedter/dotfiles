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
autocmd("Filetype", {
    pattern = "org",
    callback = function()
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end,
    group = org_settings,
})
