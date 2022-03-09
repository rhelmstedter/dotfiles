vim.cmd([[
    " for WSL on work comp
    " let g:python3_host_prog= '/usr/bin/python3'

    " for mac-mini
    let g:python3_host_prog= '/opt/homebrew/bin/python3'

    " for mbp 2015
    " let g:python3_host_prog= '/usr/local/bin/python3'

    " f-strings
    nnoremap <leader>fs maF"if<esc>`al

    augroup formatPython
        autocmd!
        autocmd BufWritePre *.py execute ':Black'
        autocmd BufWritePre *.py execute ':Isort'
    augroup END

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
    nnoremap <leader>rc :call RunTmuxPythonCell(0)<CR>
    noremap <leader>ra :call RunTmuxPythonAllCellsAbove()<CR>

]])
