local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

parser_config.org = {
    install_info = {
        url = 'https://github.com/milisims/tree-sitter-org',
        revision = 'main',
        files = {'src/parser.c', 'src/scanner.cc'},
        },
    filetype = 'org',
    }

require("org-bullets").setup {
  symbols = { "⁖", "◉", "○", "✸", "✿" }
  }

require('orgmode').setup{
  org_agenda_files = {'~/Dropbox/org/*', '~/org-mode/**/*'},
  org_default_notes_file = '~/Dropbox/org/refile.org',
  org_todo_keywords = {'TODO(t)', 'WAITING(w)', '|', 'DONE', 'CANCALLED(c)'},
  org_todo_keyword_faces = {
    WAITING = ':foreground #51afef :weight bold',
    TODO = ':foreground #98be65',
  }
}

