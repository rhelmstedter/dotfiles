"=====[ Plugins ]====================

let mapleader = " "
inoremap jk <esc>

"install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

"run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()
    Plug 'SirVer/ultisnips'
    Plug 'arcseldon/vim-dragvisuals'
    Plug 'dhruvasagar/vim-table-mode'
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
    Plug 'greghor/vim-pyShell'
    Plug 'honza/vim-snippets'
    Plug 'hrsh7th/nvim-compe'
    Plug 'joshdick/onedark.vim'
    Plug 'julienr/vim-cellmode'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/vim-peekaboo'
    Plug 'markonm/traces.vim'
    Plug 'michal-h21/vim-zettel'
    Plug 'morhetz/gruvbox'
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'preservim/nerdtree'
    Plug 'preservim/vimux'
    Plug 'reedes/vim-pencil'
    Plug 'rhysd/vim-grammarous'
    Plug 'romgrk/doom-one.vim'
    Plug 'shime/vim-livedown'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'vim-airline/vim-airline'
    Plug 'vimwiki/vimwiki'
call plug#end()


"=====[ Display ]====================

"theme
set termguicolors
syntax on
set background=dark
colorscheme doom-one
let g:airline_theme='onedark'

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

"set tabs based on filetype
augroup tabs
    autocmd!
    autocmd FileType html set tabstop=2|set shiftwidth=2|set expandtab|set nowrap
    autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab|set nowrap
    autocmd FileType markdown set tabstop=5|set shiftwidth=5|set noexpandtab|set noautoindent
augroup END

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

"from Primeagen
set incsearch
set scrolloff=8
set noswapfile
set smartcase
set ignorecase
set hidden

"=====[ Autocomplete ]====================

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" " Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" " Avoid showing message extra message when using completion
set shortmess+=c

lua require'lspconfig'.pyright.setup{}
lua require'lspconfig'.tailwindcss.setup{}
lua require'lspconfig'.bashls.setup{}

let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
let g:compe.source.emoji = v:true

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

"=====[ Word Processing ]====================

"doesn't split words
set linebreak 

"fix' backspace
set backspace=indent,eol,start

"spellcheck
function! FixLastSpellingError()
    normal! mm[s1z=`m"
endfunction
nnoremap <leader>sc :call FixLastSpellingError()<cr>

augroup SpellUnderline
  autocmd!
  autocmd FileType markdown setlocal spell spelllang=en_us
  autocmd ColorScheme *
    \ highlight SpellBad
    \   cterm=Underline
    \   ctermfg=red
    \   ctermbg=NONE
    \   term=Reverse
    \   gui=Undercurl
    \   guisp=Red
augroup end

"Grammarous 
let g:grammarous#languagetool_cmd = 'languagetool'
nmap <leader>gc :GrammarousCheck<CR> 
nmap <leader>gn <Plug>(grammarous-move-to-next-error)
nmap <leader>gp <Plug>(grammarous-move-to-previous-error)
nmap <leader>gf <Plug>(grammarous-fixit)
nmap <leader>gr <Plug>(grammarous-remove-error)
nmap <leader>go <Plug>(grammarous-open-info-window)


"=====[ Vimwiki and Vim-zettel ]====================

set nocompatible
filetype plugin on
let g:zettel_format = "%Y%m%d%H%M"
let g:vimwiki_list = [{'path': '~/Zettelkasten/zettel', 'syntax': 'markdown', 'ext': '.md'},
                     \{'path': '~/coding/Coding-in-Math-Class', 'syntax': 'markdown', 'ext': '.md'},
                     \{'path': '~/coding/Coding', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_global_ext = 0
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:nv_search_paths = ['/Zettelkasten']
let g:zettel_options = [{"front_matter" : [["tags", ""], ["citation", ""]]}]
let g:zettel_fzf_command = "rg --column --line-number --smart-case --no-heading --color=always"

"let g:markdown_fenced_languages = ['html', 'python', 'ruby', 'vim', 'lua']
nmap gm :LivedownToggle<CR>

vnoremap z :<C-U>ZettelNew<CR>

"let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4"

"adds #tags in addition to wiki tags for use in Zettlr
function! AddTags()
    normal! mm0wly$$p`mlv$:s/\%V:/ #/gA€kb€kb€ýaF:lx$
endfunction
nnoremap <leader>at :call AddTags()<cr>

nnoremap <C-e> :Buffers<CR>
"toggle file type between md and vimwiki
nnoremap <leader>md :set filetype=markdown<CR>
nnoremap <leader>vw :set filetype=vimwiki<CR>

"open zettelkasten to search notes
nnoremap <leader>zk :vsplit ~/Zettelkasten/zettel/index.md<cr> :cd %:p:h<cr>


"=====[ Telescope ]====================

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fc <cmd>Telescope command_history<cr>


"=====[ Pencil ]====================

let g:pencil#wrapModeDefault = 'soft'   "default is 'hard'

augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init({'wrap': 'hard'})
augroup END


"=====[ Goyo ]====================

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


"=====[ Nerdtree ]====================

augroup NerdTree
autocmd!
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif 
augroup END
map <leader>n :NERDTreeToggle<CR>


"=====[ Python ]====================

"run black formating from inside vim
function! RunBlack()
    normal! :w :! python3 -m black % 
endfunction
nnoremap <leader>b :call RunBlack()<cr>

"run python code from inside vim
nnoremap <F5> :w<CR>:term python3 %<CR>

"nnoremap <F5> <Esc>:w<CR>:!clear;python3 %<CR>
let g:python_highlight_all = 1

let g:python3_host_prog= '/Users/russell/.py3nvim/bin/python3'


"=====[ Data Science ]====================

"vim cell-mode parameters
let g:cellmode_use_tmux=1
let g:cellmode_tmux_panenumber=0
let g:cellmode_tmux_windowname='Python'

"ipython-shell
noremap <leader>ss :call StartPyShell()<CR>
noremap <leader>sk :call StopPyShell()<CR>

"mode execution
nnoremap <leader>sl  :call PyShellSendLine()<CR>
noremap <silent> <C-n> :call RunTmuxPythonCell(0)<CR>
noremap <leader>ra :call RunTmuxPythonAllCellsAbove()<CR>

"=====[ Firevim ]===================

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


"=====[ Usefull Remappings ]====================

"quickly edit ~/.vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"navigating windows
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()

"Remove any introduced trailing white space after moving...
let g:DVB_TrimWS = 1    

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

"copy link to mark.show presentation
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
