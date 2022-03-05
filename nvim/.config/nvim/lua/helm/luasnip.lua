require("luasnip.loaders.from_vscode").load()

local ls = require "luasnip"
-- local types = require("luasnip.util.type")

ls.config.set_config {
    history = true,
    updateevents = "TextChanged, TextChangedI",
    enable_autosnippets = true,
}

local keymap = vim.api.nvim_set_keymap

keymap("i", "<c-f>","<cmd>lua require'helm.luasnip'.forward_trigger()<CR>", { silent = true })
keymap("i", "<c-a>","<cmd>lua require'helm.luasnip'.backward_trigger()<CR>", { silent = true })
keymap("n", "<leader><leader>s","<cmd>source ~/.config/nvim/lua/helm/luasnip.lua<CR>", { silent = true })

ls.snippets = {
    python = {
        ls.parser.parse_snippet("cc", "##{\n$1\n##}\n")
    },
}


local M = {}

function M.forward_trigger()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end

function M.backward_trigger()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end

return M
