local cmp = require('cmp')
local lspkind = require('lspkind')
lspkind.init()

cmp.setup({
    snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
    },

    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping{
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
	   },
       -- ['<Tab>'] = function(fallback)
       --  if cmp.visible() then
       --      cmp.select_next_item()
       --  else
       --      fallback()
       --  end
       --  end,
       --  ['<S-Tab>'] = function(fallback)
       --  if cmp.visible() then
       --      cmp.select_prev_item()
       --  else
       --      fallback()
       --  end
       --  end,
    },

    formatting = {
        format = lspkind.cmp_format {
            with_text = false,
            menu = {
                nvim_lua = "[API]",
                nvim_lsp = "[LSP]",
                buffer = "[buf]",
                path = "[path]",
                orgmode = "[org]",
                ultisnips = "[snip]",
            },
        },
    },

    sources = cmp.config.sources({
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        { name = 'ultisnips' }, -- For ultisnips users.
        { name = 'orgmode' },
        { name = 'path' },
        { name = 'buffer', keyword_length = 5 },
    })
})

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' },
        { name = 'nvim_lsp' },
    }
})

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources{
      { name = 'path' },
      { name = 'cmdline' }
  }
})
