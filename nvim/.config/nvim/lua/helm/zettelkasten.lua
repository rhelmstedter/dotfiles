vim.g.zettel_format = "%Y%m%d%H%M"

vim.g.vimwiki_list = {
	{
		path = "~/Zettelkasten/zettel",
		syntax = "markdown",
		ext = ".md",
	},
	{
		path = "~/Coding-in-Math-Class",
		syntax = "markdown",
		ext = ".md",
	},
	{
		path = "~/coding-class",
		syntax = "markdown",
		ext = ".md",
	},
}

vim.g.nv_search_paths = "~/Zettelkasten"
vim.g.vimwiki_markdown_link_ext = 1
vim.g.vimwiki_global_ext = 0
vim.g.vimwiki_ext2syntax = { [".md"] = "markdown", [".markdown"] = "markdown", [".mdown"] = "markdown" }

vim.g.zettel_options = {
	front_matter = {
		{ tags = "" },
		{ citation = "" },
	},
}
vim.g.markdown_fenced_languages = { "html", "python", "ruby", "vim" }

-- I prefer ripgrep to ag, but honestly I just use telescope now
vim.g.zettel_fzf_command = "rg --column --line-number --smart-case --no-heading --color=always"

vim.g.fzf_layout = {
	window = {
		{ width = 0.9 },
		{ height = 0.9 },
	},
}

-- let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4"
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Nice way to see how markdown will render
keymap("n", "gm", ":LivedownToggle<CR>", opts)

-- toggle file type between md and vimwiki filetypes
keymap("n", "<leader>md", ":set filetype=markdown<CR>", opts)
keymap("n", "<leader>vw", ":set filetype=vimwiki<CR>", opts)

-- open zettelkasten to search notes while working in vim
keymap("n", "<leader>zk", ":vsplit ~/Zettelkasten/zettel/index.md<cr> :cd %:p:h<cr>", opts)

-- spellcheck
vim.cmd([[
    function! FixLastSpellingError()
    normal! mm[s1z=`m"
    endfunction
    nnoremap <leader>sc :call FixLastSpellingError()<cr>
]])

vim.cmd([[
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#textwidth = 90
let g:pencil#joinspaces = 0     " 0=one_space (def), 1=two_spaces
let g:pencil#cursorwrap = 1     " 0=disable, 1=enable (def)
let g:pencil#conceallevel = 3     " 0=disable, 1=one char, 2=hide char, 3=hide all (def)
let g:pencil#concealcursor = 'c'  " n=normal, v=visual, i=insert, c=command (def)

augroup pencil
    autocmd!
    autocmd User TelescopePreviewerLoaded setlocal wrap
    autocmd FileType markdown call pencil#init()
    autocmd FileType org         call pencil#init()
augroup END
]])

-- " don't expand links in normal mode
vim.cmd([[
    augroup hide_links
        autocmd!
        autocmd FileType vimwiki set concealcursor=nc |set conceallevel=3
        autocmd FileType markdown set concealcursor=nc |set conceallevel=3
    augroup END
]])
