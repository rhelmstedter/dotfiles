let mapleader = " "
syntax on
set termguicolors
set background=dark
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set number
set rnu
set ruler
set showcmd
set cmdheight=2
set showmatch

"set tabs based on filetype
augroup tabs
    autocmd!
    autocmd FileType html set tabstop=2|set shiftwidth=2|set expandtab|set nowrap
    autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab|set nowrap
    autocmd FileType markdown set tabstop=5|set shiftwidth=5|set noexpandtab|set noautoindent
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

"from Primeagen
set incsearch
set scrolloff=8
set noswapfile
set smartcase
set ignorecase
set hidden
set linebreak 
set backspace=indent,eol,start

"=====[ Usefull Remappings ]====================

inoremap jk <esc>

"quickly edit ~/.vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <C-s> :w<cr>

"navigating windows
nnoremap <leader>wh <C-w>h
nnoremap <leader>wj <C-w>j
nnoremap <leader>wk <C-w>k
nnoremap <leader>wl <C-w>l

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
