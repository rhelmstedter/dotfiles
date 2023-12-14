-- Extract function supports only visual mode
vim.keymap.set("x", "<leader>re", function() require('refactoring').refactor('Extract Function') end)
vim.keymap.set("x", "<leader>rf", function() require('refactoring').refactor('Extract Function To File') end)

-- Extract variable supports only visual mode
vim.keymap.set("x", "<leader>rv", function() require('refactoring').refactor('Extract Variable') end)

-- Inline func supports only normal
vim.keymap.set("n", "<leader>rI", function() require('refactoring').refactor('Inline Function') end)

-- Inline var supports both normal and visual mode
vim.keymap.set({ "n", "x" }, "<leader>ri", function() require('refactoring').refactor('Inline Variable') end)

-- Extract block supports only normal mode
vim.keymap.set("n", "<leader>rb", function() require('refactoring').refactor('Extract Block') end)
vim.keymap.set("n", "<leader>rbf", function() require('refactoring').refactor('Extract Block To File') end)
