local keymap = vim.keymap.set
local s_opts = { silent = true }

-- harpoon file
keymap("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<CR>", s_opts)
-- harpoon menu
keymap("n", "<C-h>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", s_opts)
-- fuzzy find harpoons
keymap("n", "<leader>hf", "<cmd>Telescope harpoon marks<CR>", s_opts)
-- navigate harpooned files
keymap("n", "<leader>hh", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", s_opts)
keymap("n", "<leader>hj", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", s_opts)
keymap("n", "<leader>hk", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", s_opts)
keymap("n", "<leader>hl", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", s_opts)
keymap("n", "<leader>hf", "<cmd>lua require('harpoon.ui').nav_file(5)<CR>", s_opts)
keymap("n", "<leader>hd", "<cmd>lua require('harpoon.ui').nav_file(6)<CR>", s_opts)
keymap("n", "<leader>hs", "<cmd>lua require('harpoon.ui').nav_file(7)<CR>", s_opts)
