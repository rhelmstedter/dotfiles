local snip_paths = {
    paths = {
        "~/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    },
}
require("luasnip.loaders.from_vscode").load(snip_paths)

local ls = require("luasnip")
ls.config.set_config {
    history = true,
    updateevents = "TextChanged, TextChangedI",
    enable_autosnippets = true,
}
ls.add_snippets(nil, {
    python = {
        ls.parser.parse_snippet("cc", "##{\n$1\n##}\n"),
    },
    vimwiki = {
        ls.parser.parse_snippet("[]", "[$1]($2)"),
    },
    markdown = {
        ls.parser.parse_snippet("[]", "[$1]($2)"),
    },
})

local keymap = vim.keymap.set

keymap(
    "i",
    "<c-k>",
    "<cmd>lua require'helm.luasnip'.forward_trigger()<CR>",
    { silent = true }
)
keymap(
    "i",
    "<c-a>",
    "<cmd>lua require'helm.luasnip'.backward_trigger()<CR>",
    { silent = true }
)
keymap(
    "n",
    "<leader>ls",
    "<cmd>source ~/.config/nvim/lua/helm/luasnip.lua<CR>",
    { silent = true }
)

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
