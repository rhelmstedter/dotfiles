-- function! s:goyo_enter()
--   set nonumber
--   set nornu
-- endfunction
--
-- function! s:goyo_leave()
--   set number
--   set rnu
-- endfunction
--
-- augroup Goyo
--   autocmd!
--   autocmd! User GoyoEnter nested call <SID>goyo_enter()
--   autocmd! User GoyoLeave nested call <SID>goyo_leave()
-- augroup END
--
-- nnoremap <leader>gy :Goyo<CR>
-- nnoremap <leader>gz :ZenMode<CR>
require("zen-mode").setup{
    window = {
	    backdrop = .4,
	    width = 100,
	    height = .90,
	    options = {
		   number = false,
		   relativenumber = false,
	    },
	},
}
require("twilight").setup{}

local keymap = vim.api.nvim_set_keymap
keymap("n", '<leader>gz', ':ZenMode<CR>', {silent = true})

