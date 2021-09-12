" =====[ Plugins ]====================

let mapleader = " "
inoremap jk <esc>

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'
    Plug 'morhetz/gruvbox'
    Plug 'preservim/nerdtree'
    Plug 'dhruvasagar/vim-table-mode'
    Plug 'vimwiki/vimwiki'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/goyo.vim'
    Plug 'michal-h21/vim-zettel'
    Plug 'arcseldon/vim-dragvisuals'
    Plug 'tpope/vim-fugitive'
    Plug 'reedes/vim-pencil'
    Plug 'markonm/traces.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'rhysd/vim-grammarous'
    Plug 'junegunn/vim-peekaboo'
    Plug 'preservim/vimux'
    Plug 'greghor/vim-pyShell'
    Plug 'julienr/vim-cellmode'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'shime/vim-livedown'
    Plug 'vim-python/python-syntax'
    Plug 'joshdick/onedark.vim'
    Plug 'romgrk/doom-one.vim'
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
call plug#end()


"=====[ Display ]====================

"theme
set termguicolors
syntax on
set background=dark
colorscheme doom-one
let g:airline_theme='onedark'


" set tabs
augroup tabs
    autocmd!
    autocmd FileType html set tabstop=2|set shiftwidth=2|set expandtab|set nowrap
    autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab|set nowrap
    autocmd FileType markdown set tabstop=5|set shiftwidth=5|set noexpandtab|set noautoindent
augroup END

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" show numbers
set number
set rnu
set ruler

"show commands at bottom of page
set showcmd

"show matching brackets and quotes
set showmatch

" flashes when you make an error. No beep.
set visualbell

" highlights recommended line length
augroup columnLenHighlight
  autocmd!
  autocmd BufEnter,WinEnter,FileType python,julia highlight ColorColumn ctermbg=gray guibg=#c678dd|call matchadd('ColorColumn', '\%91v', 100)
augroup END

"from Primeagen
set incsearch
set scrolloff=8
set noswapfile
set nohlsearch


"=====[ Word Processing ]====================

"doesn't split words
set linebreak 

" 'fix' backspace
set backspace=indent,eol,start

" spellcheck
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
                     \{'path': '~/Coding-in-Math-Class', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:nv_search_paths = ['/Zettelkasten']
let g:zettel_options = [{"front_matter" : [["tags", ""], ["citation", ""]]}]
let g:zettel_fzf_command = "rg --column --line-number --smart-case --no-heading --color=always"

"let g:markdown_fenced_languages = ['html', 'python', 'ruby', 'vim', 'lua']
nmap gm :LivedownToggle<CR>

vnoremap z :<C-U>ZettelNew<CR>
"let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4"

" Adds #tags in addition to wiki tags for use in Zettlr
function! AddTags()
    normal! mm0wly$$p`mlv$:s/\%V:/ #/gA€kb€kb€ýaF:lx$
endfunction
nnoremap <leader>at :call AddTags()<cr>

nnoremap <leader>r :Rg<CR>
nnoremap <C-p> :Files<CR>
nnoremap <C-e> :Buffers<CR>

"=====[ Telescope ]====================

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"=====[ Pencil ]====================

let g:pencil#wrapModeDefault = 'soft'   " default is 'hard'

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

" run black formating from inside vim
function! RunBlack()
    normal! :w :! python3 -m black % 
endfunction
nnoremap <leader>b :call RunBlack()<cr>

" run python code from inside vim
nnoremap <F5> :w<CR>:term python3 %<CR>

"nnoremap <F5> <Esc>:w<CR>:!clear;python3 %<CR>
let g:python_highlight_all = 1

let g:python3_host_prog= '/Users/russell/.py3nvim/bin/python3'


"=====[ Data Science ]====================

" vim cell-mode parameters
let g:cellmode_use_tmux=1
let g:cellmode_tmux_panenumber=0
let g:cellmode_tmux_windowname='Python'

" ipython-shell
noremap <leader>ss :call StartPyShell()<CR>
noremap <leader>sk :call StopPyShell()<CR>

" code execution
nnoremap <leader>sl  :call PyShellSendLine()<CR>
noremap <silent> <C-n> :call RunTmuxPythonCell(0)<CR>
noremap <leader>ra :call RunTmuxPythonAllCellsAbove()<CR>


"=====[ Autocomplete ]====================
"
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number colmn into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd FileType markdown let b:coc_suggest_disable = 1
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"=====[ Firevim ]===================
"

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


"=====[ Random ]====================


" quickly edit ~/.vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Navigating windows
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

"open zettelkasten to search notes
nnoremap <leader>zk :vsplit ~/Zettelkasten/zettel/index.md<cr> :cd %:p:h<cr>

"copy to clipboard on mac
nnoremap <leader>p "*p
vnoremap <leader>y "*y
"
"copy link to mark.show presentation
nnoremap <leader>ms :!curl -F file=@% https://mark.show\|pbcopy<cr>

" insert datetime
nmap <F3> i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>
