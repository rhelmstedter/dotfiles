local keymap = vim.keymap.set
local s_opts = { silent = true }

-- harpoon file
keymap("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<CR>", s_opts)
-- harpoon menu
keymap("n", "<C-h>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", s_opts)
-- fuzzy find harpoons
keymap("n", "<leader>hf", "<cmd>Telescope harpoon marks<CR>", s_opts)
-- navigate harpooned files
keymap("n", "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", s_opts)
keymap("n", "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", s_opts)
keymap("n", "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", s_opts)
keymap("n", "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", s_opts)

keymap("n", "<leader>6", "<cmd>lua require('harpoon.ui').nav_file(6)<CR>", s_opts)
keymap("n", "<leader>7", "<cmd>lua require('harpoon.ui').nav_file(7)<CR>", s_opts)
keymap("n", "<leader>8", "<cmd>lua require('harpoon.ui').nav_file(8)<CR>", s_opts)
keymap("n", "<leader>9", "<cmd>lua require('harpoon.ui').nav_file(9)<CR>", s_opts)
