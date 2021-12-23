
"{{{=====[ Settings ]==========================================================

let mapleader = " "
inoremap jk <esc>

"show numbers
set number
set rnu
set ruler

"show commands at bottom of page
set showcmd

"show matching brackets and quotes
set showmatch

"flashes when you make an error. No beep.
set visualbell
set incsearch
set scrolloff=8
set noswapfile
set smartcase
set ignorecase
set hidden
set foldmethod=marker

"}}}
"{{{=====[ Plugins ]===========================================================

"run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \| PlugInstall --sync | source $MYVIMRC
            \| endif

call plug#begin()
Plug 'sbdchd/neoformat'
Plug 'SirVer/ultisnips'
Plug 'akinsho/org-bullets.nvim'
Plug 'brymer-meneses/grammar-guard.nvim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'greghor/vim-pyShell'
Plug 'honza/vim-snippets'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'joshdick/onedark.vim'
Plug 'julienr/vim-cellmode'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'kristijanhusak/orgmode.nvim'
Plug 'lervag/vimtex'
Plug 'lukas-reineke/headlines.nvim'
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
Plug 'romgrk/doom-one.vim'
Plug 'shime/vim-livedown'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vimwiki/vimwiki'
Plug 'williamboman/nvim-lsp-installer'
Plug 'folke/zen-mode.nvim'
Plug 'jonstoler/werewolf.vim'
Plug 'ishan9299/nvim-solarized-lua'
Plug 'Th3Whit3Wolf/Dusk-til-Dawn.nvim'
call plug#end()

"}}}
"{{{=====[ Display ]===========================================================

"theme
set termguicolors
syntax on
let g:dusk_til_dawn_light_theme = 'solarized'
let g:dusk_til_dawn_dark_theme = 'doom-one'
lua require'Dusk-til-Dawn'.timeMan()()
if strftime("%H") > 19
  let g:airline_theme='onedark'
else
  let g:airline_theme='solarized'
endif
let g:airline_powerline_fonts = 1
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

"Faster Update time
set updatetime=1000
"}}}
"{{{=====[ Auto Commands ]=====================================================

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
    autocmd BufEnter,WinEnter,FileType python,julia highlight ColorColumn ctermbg=gray guibg=#c678dd|call matchadd('ColorColumn', '\%91v', 100)
augroup END

"}}}
"{{{=====[ Autocomplete ]======================================================

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

lua <<EOF
-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
    -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
end,
},
    mapping = {
        ['<Tab>'] = function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        else
            fallback()
        end
    end,
    ['<S-Tab>'] = function(fallback)
    if cmp.visible() then
        cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
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
  -- { name = 'vsnip' }, -- For vsnip users.
  { name = 'luasnip' }, -- For luasnip users.
  { name = 'ultisnips' }, -- For ultisnips users.
  -- { name = 'snippy' }, -- For snippy users.
  }, {
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
      { name = 'path' }
      }, {
      { name = 'cmdline' }
      })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['pyright'].setup {
      capabilities = capabilities
      }
  require('lspconfig')['tailwindcss'].setup {
      capabilities = capabilities
      }

  require('lspconfig')['bashls'].setup {
      capabilities = capabilities
      }
  require('lspconfig')['pylsp'].setup {
      capabilities = capabilities
      }
EOF

lua << EOF
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    underline = true,
    signs = true,
    }
)
vim.api.nvim_set_keymap("n", "gn", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gp", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", {noremap = true, silent = true})
EOF

"}}}
"{{{=====[ Latex ]=============================================================

let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

"}}}
"{{{=====[ Word Processing ]===================================================

"doesn't split words
set linebreak

"fix backspace
set backspace=indent,eol,start

"spellcheck
function! FixLastSpellingError()
    normal! mm[s1z=`m"
endfunction
nnoremap <leader>sc :call FixLastSpellingError()<cr>

" lua << EOF
"   require("grammar-guard").init()

"   -- setup LSP config
"   require("lspconfig").grammar_guard.setup{
"     settings = {
"       ltex = {
"       enabled = { "latex", "tex", "bib", "markdown" },
"       language = "en",
"       diagnosticSeverity = "information",
"       setenceCacheSize = 2000,
"       additionalRules = {
"       enablePickyRules = true,
"       motherTongue = "en",
"       },
"   trace = { server = "verbose" },
"   dictionary = {},
"   disabledRules = {},
"   hiddenFalsePositives = {},
"   },
"     },
" }
" EOF

"}}}
"{{{=====[ Vimwiki and Vim-zettel ]============================================

set nocompatible
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
let g:markdown_fenced_languages = ['html', 'python', 'ruby', 'vim', 'lua']

"I prefer ripgrep to ag, but honestly I just use telescope now
let g:zettel_fzf_command = "rg --column --line-number --smart-case --no-heading --color=always"

"let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4"
"Nice way to see how markdown will render
nmap gm :LivedownToggle<CR>

vnoremap nz :<C-U>ZettelNew<CR>

"adds #tags in addition to wiki tags for use in Zettlr
function! AddTags()
    normal! mm0wly$$p`mlv$:s/\%V:/ #/gA€kb€kb€ýaF:lx$
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
augroup END

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

require('orgmode').setup({
org_agenda_files = {'~/Dropbox/org/*', '~/org-mode/**/*'},
org_default_notes_file = '~/Dropbox/org/refile.org',
})

require("headlines").setup()
EOF

function! SetOrgSets()
    setlocal conceallevel=2
    setlocal concealcursor=nc
    setlocal nowrap
endfunction
autocmd FileType org call SetOrgSets()

"}}}
"{{{=====[ Nerdtree ]==========================================================

augroup NerdTree
    autocmd!
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END
map <leader>n :NERDTreeToggle<CR>

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

"run black formating from inside vim
function! RunBlack()
    normal! :w :! python3 -m black %
endfunction
nnoremap <leader>b :Neoformat black<cr>

" Enable alignment
let g:neoformat_basic_format_align = 1
" Enable tab to space conversion
let g:neoformat_basic_format_retab = 1
" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1


"run python code from inside vim
"
nnoremap <F5> :w<CR>:term python3 %<CR>

"nnoremap <F5> <Esc>:w<CR>:!clear;python3 %<CR>
let g:python_highlight_all = 1
"let g:python3_host_prog= '/opt/homebrew/bin/python3'

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
"{{{=====[ Firevim ]===========================================================

let g:firenvim_config = {
            \ 'localSettings': {
                \ '.*': {
                    \ 'cmdline': 'neovim',
                    \ 'content': 'text',
                    \ 'priority': 0,
                    \ 'selector': 'textarea',
                    \ 'takeover': 'never',
                    \ },
                    \ }
                    \ }

"}}}
"{{{=====[ Useful Remappings ]=================================================

"save
nnoremap <leader>w :w<cr>

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

"make Y behave
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

"}}}
