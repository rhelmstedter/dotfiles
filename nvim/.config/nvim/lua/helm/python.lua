vim.cmd([[
    " " Enable alignment
    " let g:neoformat_basic_format_align = 1
    " " Enable tab to space conversion
    " let g:neoformat_basic_format_retab = 1
    " " Enable trimmming of trailing whitespace
    " let g:neoformat_basic_format_trim = 1

    " for WSL on work comp
    " let g:python3_host_prog= '/usr/bin/python3'

    " for mac-mini
    let g:python3_host_prog= '/opt/homebrew/bin/python3'

    " for mbp 2015
    " let g:python3_host_prog= '/usr/local/bin/python3'

    " f-strings
    nnoremap <leader>fs maF"if<esc>`al

    autocmd BufWritePre *.py execute ':Black'

    "
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

    augroup indent
        autocmd!
        autocmd FileType python setlocal indentkeys-=<:>
        autocmd FileType python setlocal indentkeys-=:
    augroup END
]])
