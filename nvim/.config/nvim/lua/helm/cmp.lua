local cmp = require("cmp")
local lspkind = require("lspkind")

lspkind.init()
cmp.setup {
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = {
        -- ["<C-j>"] = cmp.mapping.select_next_item(),
        -- ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        -- ["<C-y>"] = cmp.config.disable,
        ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        ["<C-y>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
    },
    formatting = {
        format = lspkind.cmp_format {
            with_text = false,
            menu = {
                nvim_lsp = "LSP",
                -- codeium = "CODE",
                luasnip = "SNIP",
                path = "PATH",
                buffer = "BUF",
                -- orgmode = "ORG",
                nvim_lua = "API",
            },
        },
    },
    sources =  {
        { name = "nvim_lsp" },
        -- { name = "codeium" },
        -- { name = "orgmode" },
        { name = "path" },
        { name = "nvim_lua" },
        { name = "luasnip" }, -- For luasnip users.
        { name = "buffer", keyword_length = 4 },
    },
}
cmp.setup.cmdline("/", {
    sources = {
        { name = "buffer" },
        { name = "nvim_lsp" },
        { name = "path" },
    },
})
cmp.setup.cmdline(":", {
    sources = cmp.config.sources {
        { name = "path" },
        { name = "cmdline" },
    },
})
