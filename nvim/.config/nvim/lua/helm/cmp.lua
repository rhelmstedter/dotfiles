local cmp = require "cmp"

local lspkind = require "lspkind"
lspkind.init()

cmp.setup {
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = {
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i','c'}),
        ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i','c'}),
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
    },

    formatting = {
        format = lspkind.cmp_format {
            with_text = false,
            menu = {
                luasnip = "SNIP",
                nvim_lsp = "LSP",
                path = "PATH",
                buffer = "BUF",
                orgmode = "ORG",
                nvim_lua = "API",
            },
        },
    },

    sources = cmp.config.sources {
        { name = "luasnip" }, -- For luasnip users.
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "orgmode" },
        { name = "path" },
        { name = "buffer", keyword_length = 3 },
    },
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
    sources = {
        { name = "buffer" },
        { name = "nvim_lsp" },
        { name = "path" },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    sources = cmp.config.sources {
        { name = "path" },
        { name = "cmdline" },
    },
})
