local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- highlights recommended line length
vim.cmd [[
    augroup columnLenHighlight
          autocmd!
          autocmd FileType python highlight ColorColumn ctermbg=gray guibg=#a9a1e1|call matchadd('ColorColumn', '\%90v', 100)
    augroup END
]]

-- set tabs based on filetype
vim.cmd [[
    augroup tabs
          autocmd!
          autocmd FileType html set tabstop=2|set shiftwidth=2|set expandtab
          autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab|set foldmethod=expr |set foldexpr=nvim_treesitter#foldexpr()
          autocmd FileType markdown set tabstop=5|set shiftwidth=5|set noexpandtab|set noautoindent
          autocmd FileType vimwiki set tabstop=5|set shiftwidth=5|set noexpandtab|set noautoindent
    augroup END
]]


-- highlight yanked region
local highlight_yank = augroup("highlight_yank", { clear = true })

autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank { higroup = "IncSearch", timeout = 300 }
    end,
    group = highlight_yank,
})

-- local hide_links = augroup("hide_links", { clear = true })

vim.cmd [[
    augroup hide_links
        autocmd!
        autocmd FileType vimwiki set concealcursor=nc |set conceallevel=3
        autocmd FileType markdown set concealcursor=nc |set conceallevel=3
    augroup END
]]
