 
"{{{=====[ Settings ]==========================================================

set backspace=indent,eol,start
set cmdheight=2
set completeopt=menuone,noinsert,noselect
set expandtab
set fileencodings=utf-8
set foldmethod=marker
set hidden
set ignorecase
set incsearch
set linebreak
set nocompatible
set noswapfile
set number
set numberwidth=5
set relativenumber
set scrolloff=8
set shiftwidth=2
set shortmess+=c
set showcmd
set showmatch
set smartcase
set splitright
set softtabstop=2
set tabstop=2
set termguicolors
set undodir=~/.config/nvim/undodir
set undofile
set updatetime=250
set visualbell

"}}}
"{{{=====[ Useful Mappings ]===================================================

let mapleader = " "
inoremap jk <esc>

"save
nnoremap <leader>w :w<CR>

"quickly edit ~/.vimrc
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"navigating windows
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

"change directory to current file
nnoremap <leader>cd :cd %:p:h<CR>

"copy to clipboard on mac
nnoremap <leader>p "+p
vnoremap <leader>y "+y

"delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

"make Y behave like D and C
nnoremap Y yg_

"copy link to mark.show presentation on mac
nnoremap <leader>ms :!curl -F file=@% https://mark.show\|pbcopy<cr>

"insert datetime
nmap <F3> i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>

"clear search highlighting
nnoremap <esc> :noh<return><esc>
inoremap <esc> <esc>:noh<return><esc>

"center searches
nnoremap n nzzzv
nnoremap N Nzzzv

"move visuals lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"open html file
nnoremap <leader>o :w<CR>:!open %<CR>

"Explore File
nnoremap <leader>n :Ex<CR>

"}}}
"{{{=====[ Plugins ]===========================================================

"run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \| PlugInstall --sync | source $MYVIMRC
            \| endif

call plug#begin()
Plug 'SirVer/ultisnips'
Plug 'Th3Whit3Wolf/Dusk-til-Dawn.nvim'
Plug 'akinsho/org-bullets.nvim'
Plug 'brymer-meneses/grammar-guard.nvim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'folke/zen-mode.nvim'
Plug 'greghor/vim-pyShell'
Plug 'honza/vim-snippets'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'https://gitlab.com/yorickpeterse/vim-paper.git'
Plug 'julienr/vim-cellmode'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'kristijanhusak/orgmode.nvim'
Plug 'lervag/vimtex'
Plug 'markonm/traces.vim'
Plug 'michal-h21/vim-zettel'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'preservim/vimux'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'reedes/vim-pencil'
Plug 'NTBBloodbath/doom-one.nvim'
Plug 'sbdchd/neoformat'
Plug 'shime/vim-livedown'
Plug 'numToStr/Comment.nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vimwiki/vimwiki'
Plug 'voldikss/vim-floaterm'
Plug 'williamboman/nvim-lsp-installer'
Plug 'xiyaowong/nvim-transparent'
Plug 'Shatur/neovim-ayu'
Plug 'vim-scripts/ironman.vim'
call plug#end()

"}}}
"{{{=====[ Display ]===========================================================

" Change theme based on time of day
" Winter sunset at 5pm Summer sunset at 8pm
let g:sunset = 17
let g:sunrise = 7

if strftime("%H") >= sunset
    let g:airline_theme='onedark'
elseif  strftime("%H") < sunrise
    let g:airline_theme='onedark'
else
    let g:airline_theme='transparent'
endif

let g:dusk_til_dawn_light_theme = 'doom-one'
let g:dusk_til_dawn_dark_theme = 'doom-one'
let g:dusk_til_dawn_dawn = sunrise
let g:dusk_til_dawn_night = sunset
lua require'Dusk-til-Dawn'.timeMan()()
let g:airline_powerline_fonts = 1

syntax on

"}}}
"{{{=====[ Auto Commands ]=====================================================

"highlights recommended line length
augroup columnLenHighlight
  autocmd!
  autocmd BufEnter,WinEnter,FileType python highlight ColorColumn ctermbg=gray guibg=#a9a1e1|call matchadd('ColorColumn', '\%90v', 100)
augroup END

"set tabs based on filetype
augroup tabs
  autocmd!
  autocmd FileType html set tabstop=2|set shiftwidth=2|set expandtab|set nowrap
  autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab|set nowrap|set nospell
  autocmd FileType markdown set tabstop=5|set shiftwidth=5|set noexpandtab|set noautoindent|set spell
augroup END

"Save folds after closing
augroup folds
    autocmd!
    if "" != expand("%")
        autocmd BufWinLeave *.* mkview
    endif
    autocmd BufWinEnter *.* silent! loadview
augroup END

"highlight yanked region
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300}
augroup END

"highlights recommended line length
augroup columnLenHighlight
    autocmd!
    autocmd BufEnter,WinEnter,FileType python,julia highlight ColorColumn ctermbg=gray guibg=#c678dd|call matchadd('ColorColumn', '\%81v', 100)
augroup END

"}}}
"{{{=====[ Autocomplete ]======================================================

lua <<EOF
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
    vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
  end,
  },
  mapping = {
        ['<Tab>'] = function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        else
            fallback()
        end
        end,
        ['<S-Tab>'] = function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        else
            fallback()
        end
        end,
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'ultisnips' }, -- For ultisnips users.
      { name = 'orgmode' },
      { name = 'path' },
      { name = 'buffer' },
  })
})

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
      }
    })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
      { name = 'path' },
      { name = 'cmdline' }
  })
})
EOF

let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"}}}
"{{{=====[ LSP ]===============================================================

lua << EOF
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end
  -- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Add lsp servers to the lua table
local servers = { 'grammarly', 'pyright', 'tailwindcss', 'bashls', 'pylsp' }

for _, server in ipairs(servers) do
    require('lspconfig')[server].setup {
        capabilities = capabilities
    }
end

-- Diagnostics for LSP

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        underline = false,
        signs = true,
    }
)


local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {}
    server:setup(opts)
end)

EOF

"}}}
"{{{=====[ Latex ]=============================================================

let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0
"set conceallevel=1
let g:tex_conceal='abdmg'

"}}}
"{{{=====[ Word Processing ]===================================================


"spellcheck
function! FixLastSpellingError()
    normal! mm[s1z=`m"
endfunction
nnoremap <leader>sc :call FixLastSpellingError()<cr>


"}}}
"{{{=====[ Vimwiki and Vim-zettel ]============================================

filetype plugin on
let g:zettel_format = "%Y%m%d%H%M"
"Main zettelkasten plus two github repos I use for work
let g:vimwiki_list = [{'path': '~/Zettelkasten/zettel', 'syntax': 'markdown', 'ext': '.md'},
            \{'path': '~/Coding-in-Math-Class', 'syntax': 'markdown', 'ext': '.md'},
            \{'path': '~/coding-class', 'syntax': 'markdown', 'ext': '.md'}]

" Why learn vimwiki format when I sort of know markdown?
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_global_ext = 0
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:nv_search_paths = ['/Zettelkasten']
let g:zettel_options = [{"front_matter" : [["tags", ""], ["citation", ""]]}]
let g:markdown_fenced_languages = ['html', 'python', 'ruby', 'vim']

"I prefer ripgrep to ag, but honestly I just use telescope now
let g:zettel_fzf_command = "rg --column --line-number --smart-case --no-heading --color=always"

"let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4"
"Nice way to see how markdown will render
nmap gm :LivedownToggle<CR>

vnoremap nz :<C-U>ZettelNew<CR>

"adds #tags in addition to wiki tags for use in Zettlr
function! AddTags()
    normal! mm0wly$$p`mlv$:s/\%V:/ #/gA?kb?kb??aF:lx$
endfunction
nnoremap <leader>at :call AddTags()<cr>
nnoremap <C-e> :Buffers<CR>

"toggle file type between md and vimwiki filetypes
nnoremap <leader>md :set filetype=markdown<CR>
nnoremap <leader>vw :set filetype=vimwiki<CR>

"open zettelkasten to search notes while working in vim
nnoremap <leader>zk :vsplit ~/Zettelkasten/zettel/index.md<cr> :cd %:p:h<cr>

"don't expand links in normal mode
augroup hide_links
  autocmd!
  autocmd FileType vimwiki set concealcursor=nc| set conceallevel=2|
  autocmd FileType markdown set concealcursor=nc| set conceallevel=2|
augroup END

"}}}
"{{{=====[ Telescope ]=========================================================

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fc <cmd>Telescope command_history<cr>

"}}}
"{{{=====[ Pencil ]============================================================

let g:pencil#wrapModeDefault = 'soft'   "default is 'hard'

augroup pencil
    autocmd!
    autocmd FileType markdown,mkd call pencil#init()
    autocmd FileType text         call pencil#init()
    autocmd FileType org         call pencil#init()
augroup END

"}}}
"{{{=====[ Comment ]===========================================================

lua << EOF
require('Comment').setup{ }
EOF

"}}}
"{{{=====[ Less Distractions ]=================================================

function! s:goyo_enter()
    set nonumber
    set nornu
endfunction

function! s:goyo_leave()
    set number
    set rnu
endfunction

augroup Goyo
    autocmd!
    autocmd! User GoyoEnter nested call <SID>goyo_enter()
    autocmd! User GoyoLeave nested call <SID>goyo_leave()
augroup END

nnoremap <leader>gy :Goyo<CR>
nnoremap <leader>gz :ZenMode<CR>

"}}}
"{{{=====[ Orgmode ]===========================================================

lua << EOF
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.org = {
    install_info = {
        url = 'https://github.com/milisims/tree-sitter-org',
        revision = 'main',
        files = {'src/parser.c', 'src/scanner.cc'},
        },
    filetype = 'org',
    }

require'nvim-treesitter.configs'.setup {
    -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
    highlight = {
    enable = true,
    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
    },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
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

EOF

augroup orgSettings
    autocmd!
    autocmd FileType org set concealcursor=nc| set conceallevel=2|set foldmethod=expr |set foldexpr=nvim_treesitter#foldexpr()
augroup END


"}}}
"{{{=====[ Treesitter ]========================================================

lua <<EOF
require'nvim-treesitter.configs'.setup {
    highlight = {
    enable = true,
    },
}
require "nvim-treesitter.highlight"
vim.treesitter.highlighter.hl_map.error = nil
EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
    incremental_selection = {
    enable = true,
    keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
        },
    },
}
EOF

"}}}
"{{{=====[ Python ]============================================================

" Enable alignment
let g:neoformat_basic_format_align = 1
" Enable tab to space conversion
let g:neoformat_basic_format_retab = 1
" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

let g:python_highlight_all = 1


"for WSL on work comp
"let g:python3_host_prog= '/usr/bin/python3'

"for mac-mini
let g:python3_host_prog= '/opt/homebrew/bin/python3'

" for mbp 2015
" let g:python3_host_prog= '/usr/local/bin/python3'

nnoremap <F5> :w<CR> :FloatermNew python3 %<CR>
"run some tests
nnoremap <leader>t :w<CR> :FloatermNew pytest -svv<CR>

"f-strings
nnoremap <leader>fs maF"if<esc>`al

let g:python_highlight_all = 1
let g:neoformat_enabled_python = ['black']
nnoremap <leader>b :Neoformat<CR>

"}}}
"{{{=====[ Data Science ]======================================================

"vim cell-mode parameters
let g:cellmode_use_tmux=1
let g:cellmode_tmux_panenumber=0
let g:VimuxRunnerType = "window"
let g:cellmode_tmux_windowname='Python'

"ipython-shell
noremap <leader>ss :call StartPyShell()<CR>
noremap <leader>sk :call StopPyShell()<CR>

"mode execution
nnoremap <leader>sl  :call PyShellSendLine()<CR>
nnoremap <leader>r :call RunTmuxPythonCell(0)<CR>
noremap <leader>ra :call RunTmuxPythonAllCellsAbove()<CR>

"}}}
"{{{=====[ Netrw ]=============================================================

let g:netrw_banner = 0

"}}}
"{{{=====[ Floaterm ]==========================================================

let g:floaterm_keymap_new    = '<leader>ft'
let g:floaterm_gitcommit='floaterm'
let g:floaterm_autoinsert=1
let g:floaterm_width=0.9
let g:floaterm_height=0.9
let g:floaterm_wintitle=0
let g:floaterm_title=''
hi FloatermBorder guibg=none guifg='#000000'
"}}}
