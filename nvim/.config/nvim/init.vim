" {{{=====[ Useful Mappings ]===================================================

let mapleader = " "
inoremap jk <esc>

" save
nnoremap <leader>w :w<CR>

" quickly edit ~/.vimrc
nnoremap <leader><leader>s :source $MYVIMRC<cr>

" navigating windows
" nnoremap <leader>h <C-w>h
" nnoremap <leader>j <C-w>j
" nnoremap <leader>k <C-w>k
" nnoremap <leader>l <C-w>l

" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" change directory to current file
nnoremap <leader>cd :cd %:p:h<CR>

" copy to clipboard on mac
nnoremap <leader>p "+p
vnoremap <leader>y "+y

" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" make Y behave like D and C
nnoremap Y yg_

" copy link to mark.show presentation on mac
nnoremap <leader>ms :!curl -F file=@% https://mark.show\|pbcopy<cr>

" insert datetime
nmap <F3> i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>

" clear search highlighting
nnoremap <esc> :noh<return><esc>
inoremap <esc> <esc>:noh<return><esc>

" center searches
nnoremap n nzzzv
nnoremap N Nzzzv

" move visuals lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" open html file
nnoremap <leader>o :w<CR>:!open %<CR>

" Explore File
nnoremap <leader>n :Ex<CR>

"}}}
"{{{=====[ Plugins ]===========================================================

" " run PlugInstall if there are missing plugins
" autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
"       \| PlugInstall --sync | source $MYVIMRC
"       \| endif
"
" call plug#begin()
" " Plug 'SirVer/ultisnips'
" " Plug 'quangnguyen30192/cmp-nvim-ultisnips'
" Plug 'nvim-lualine/lualine.nvim'
" " If you want to have icons in your statusline choose one of these
" Plug 'kyazdani42/nvim-web-devicons'
" Plug 'L3MON4D3/LuaSnip'
" Plug 'saadparwaiz1/cmp_luasnip'
" Plug 'rafamadriz/friendly-snippets'
" Plug 'Th3Whit3Wolf/Dusk-til-Dawn.nvim'
" Plug 'akinsho/org-bullets.nvim'
" Plug 'brymer-meneses/grammar-guard.nvim'
" Plug 'dhruvasagar/vim-table-mode'
" Plug 'folke/zen-mode.nvim'
" Plug 'folke/twilight.nvim'
" Plug 'greghor/vim-pyShell'
" Plug 'honza/vim-snippets'
" Plug 'hrsh7th/cmp-buffer'
" Plug 'hrsh7th/cmp-cmdline'
" Plug 'hrsh7th/cmp-nvim-lsp'
" Plug 'hrsh7th/cmp-path'
" Plug 'hrsh7th/nvim-cmp'
" Plug 'https://gitlab.com/yorickpeterse/vim-paper.git'
" Plug 'julienr/vim-cellmode'
" Plug 'junegunn/fzf'
" Plug 'junegunn/fzf.vim'
" Plug 'junegunn/goyo.vim'
" Plug 'junegunn/vim-peekaboo'
" Plug 'kristijanhusak/orgmode.nvim'
" Plug 'lervag/vimtex'
" Plug 'markonm/traces.vim'
" Plug 'michal-h21/vim-zettel'
" Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-telescope/telescope.nvim'
" Plug 'nvim-telescope/telescope-fzy-native.nvim'
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'preservim/vimux'
" Plug 'reedes/vim-pencil'
" Plug 'NTBBloodbath/doom-one.nvim'
" Plug 'sbdchd/neoformat'
" Plug 'shime/vim-livedown'
" Plug 'numToStr/Comment.nvim'
" Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-surround'
" " Plug 'vim-airline/vim-airline'
" " Plug 'vim-airline/vim-airline-themes'
" Plug 'vimwiki/vimwiki'
" Plug 'voldikss/vim-floaterm'
" Plug 'williamboman/nvim-lsp-installer'
" Plug 'xiyaowong/nvim-transparent'
" Plug 'onsails/lspkind-nvim'
" call plug#end()

lua require('helm')
"}}}
"{{{=====[ Display ]===========================================================

" Change theme based on time of day
" Winter sunset at 5pm Summer sunset at 8pm
let g:sunrise = 7
let g:sunset = 8

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

" highlights recommended line length
augroup columnLenHighlight
  autocmd!
  autocmd BufEnter,WinEnter,FileType python highlight ColorColumn ctermbg=gray guibg=#a9a1e1|call matchadd('ColorColumn', '\%90v', 100)
augroup END

" set tabs based on filetype
augroup tabs
  autocmd!
  autocmd FileType html set tabstop=2|set shiftwidth=2|set expandtab
  autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab|set foldmethod=expr |set foldexpr=nvim_treesitter#foldexpr()
  autocmd FileType markdown set tabstop=5|set shiftwidth=5|set noexpandtab|set noautoindent
  autocmd FileType vimwiki set tabstop=5|set shiftwidth=5|set noexpandtab|set noautoindent
augroup END

" Save folds after closing
augroup folds
  autocmd!
  if "" != expand("%")
    autocmd BufWinLeave *.* mkview
  endif
  autocmd BufWinEnter *.* silent! loadview
augroup END

" highlight yanked region
augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300}
augroup END

"}}}
"{{{=====[ UltiSnips ]=========================================================

" let g:UltiSnipsExpandTrigger="<c-l>"
" let g:UltiSnipsJumpForwardTrigger="<c-l>"
" let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"}}}
"{{{=====[ Latex ]=============================================================

" let g:tex_flavor='latex'
" let g:vimtex_quickfix_mode=0
" let g:tex_conceal='abdmg'

"}}}
"{{{=====[ Word Processing ]===================================================

" spellcheck
function! FixLastSpellingError()
  normal! mm[s1z=`m"
endfunction
nnoremap <leader>sc :call FixLastSpellingError()<cr>


"}}}
"{{{=====[ Vimwiki and Vim-zettel ]============================================

filetype plugin on
let g:zettel_format = "%Y%m%d%H%M"
let g:vimwiki_list = [
    \{'path': '~/Zettelkasten/zettel', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Coding-in-Math-Class', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/coding-class', 'syntax': 'markdown', 'ext': '.md'},
    \]

" Why learn vimwiki format when I sort of know markdown?
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_global_ext = 0
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:nv_search_paths = ['/Zettelkasten']
let g:zettel_options = [{"front_matter" : [["tags", ""], ["citation", ""]]}]
let g:markdown_fenced_languages = ['html', 'python', 'ruby', 'vim']

" I prefer ripgrep to ag, but honestly I just use telescope now
let g:zettel_fzf_command = "rg --column --line-number --smart-case --no-heading --color=always"

" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
" let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4"
" Nice way to see how markdown will render
nmap gm :LivedownToggle<CR>

" toggle file type between md and vimwiki filetypes
nnoremap <leader>md :set filetype=markdown<CR>
nnoremap <leader>vw :set filetype=vimwiki<CR>

" open zettelkasten to search notes while working in vim
nnoremap <leader>zk :vsplit ~/Zettelkasten/zettel/index.md<cr> :cd %:p:h<cr>

" don't expand links in normal mode
augroup hide_links
  autocmd!
  autocmd FileType vimwiki set concealcursor=nc |set conceallevel=2
  autocmd FileType markdown set concealcursor=nc |set conceallevel=2
augroup END

"}}}
"{{{=====[ Pencil ]============================================================

let g:pencil#wrapModeDefault = 'soft'   "default is 'hard'
let g:pencil#textwidth = 90
let g:pencil#autoformat = 1 " 0=disable, 1=enable (def)

augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType org         call pencil#init()
augroup END

"}}}
"{{{=====[ Comment ]===========================================================

lua << EOF
require('Comment').setup{ }
EOF

"}}}
"{{{=====[ Orgmode ]===========================================================



"}}}
"{{{=====[ Python ]============================================================

" Enable alignment
let g:neoformat_basic_format_align = 1
" Enable tab to space conversion
let g:neoformat_basic_format_retab = 1
" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

" for WSL on work comp
" let g:python3_host_prog= '/usr/bin/python3'

" for mac-mini
let g:python3_host_prog= '/opt/homebrew/bin/python3'

" for mbp 2015
" let g:python3_host_prog= '/usr/local/bin/python3'

nnoremap <F5> :w<CR> :FloatermNew python3 %<CR>
" run some tests
nnoremap <leader>t :w<CR> :FloatermNew pytest -svv<CR>

" f-strings
nnoremap <leader>fs maF"if<esc>`al

let g:neoformat_enabled_python = ['black']
nnoremap <leader>b :Neoformat<CR>

"}}}
"{{{=====[ Data Science ]======================================================

" vim cell-mode parameters
let g:cellmode_use_tmux=1
let g:cellmode_tmux_panenumber=0
let g:VimuxRunnerType = "window"
let g:cellmode_tmux_windowname='Python'

" ipython-shell
noremap <leader>ss :call StartPyShell()<CR>
noremap <leader>sk :call StopPyShell()<CR>

" mode execution
nnoremap <leader>sl  :call PyShellSendLine()<CR>
" nnoremap <leader>r :call RunTmuxPythonCell(0)<CR>
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
