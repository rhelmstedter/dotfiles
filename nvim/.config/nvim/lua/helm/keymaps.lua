vim.cmd [[
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
]]
