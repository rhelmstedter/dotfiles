vim = vim -- hack to avoid lsp warnings

local s_opts = { silent = true }
local keymap = vim.keymap.set
local refs =
"<cmd>lua require'telescope.builtin'.lsp_references(require('telescope.themes').get_dropdown({layout = 'vertical', layout_config= {height = 0.4, width = 0.8 }}))<cr>"

require("mason").setup({
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

-- Diagnostic Mappings
keymap("n", "<leader>e", vim.diagnostic.open_float, s_opts)
keymap("n", "[d", vim.diagnostic.goto_prev, s_opts)
keymap("n", "]d", vim.diagnostic.goto_next, s_opts)
keymap("n", "<leader>q", vim.diagnostic.setloclist, s_opts)
-- LSP Mappings.
keymap("n", "gD", vim.lsp.buf.declaration, s_opts)
keymap("n", "gd", vim.lsp.buf.definition, s_opts)
keymap("n", "K", vim.lsp.buf.hover, s_opts)
keymap("n", "gi", vim.lsp.buf.implementation, s_opts)
keymap("n", "<C-k>", vim.lsp.buf.signature_help, s_opts)
keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, s_opts)
keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, s_opts)
keymap("n", "<leader>D", vim.lsp.buf.type_definition, s_opts)
keymap("n", "<leader>rn", vim.lsp.buf.rename, s_opts)
keymap("n", "<leader>ca", vim.lsp.buf.code_action, s_opts)
keymap("n", "gr", refs, s_opts)
keymap("n", "<leader>f", vim.lsp.buf.format, {})
keymap(
    "n",
    "<leader>wl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    {}
)

-- Setup lspconfig for autocompletion.
local capabilities = require("cmp_nvim_lsp").default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)
local servers = {
    "lua_ls",
    "tailwindcss",
    "bashls",
}

for _, lsp in pairs(servers) do
    require("lspconfig")[lsp].setup {
        capabilities = capabilities,
        flags = {},
        no_wait = true,
    }
end

require('lspconfig').pylsp.setup {
    flags = {},
    settings = {
        -- configure plugins in pylsp
        pylsp = {
            plugins = {
                pyflakes = { enabled = false },
                pylint = { enabled = false },
                rope_autoimport = { enabled = false },
            },
        },
    },
}
require 'lspconfig'.ruff_lsp.setup {
    init_options = {
        settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = {},
        }
    }
}

-- -- pyright is only used for auto import; turned off everything else
-- require("lspconfig")["pyright"].setup {
--     capabilities = capabilities,
--     handlers = {
--         ['textDocument/publishDiagnostics'] = function(...) end
--     },
--     settings = {
--         typeCheckingMode = 'off',
--         python = {
--             analysis = {
--                 typeCheckingMode = 'off',
--                 autoImportCompletions = true,
--             },
--         },
--         pyright = {
--             disableDiagnostics = false,
--             -- disableLanguageServices = true,
--             analysis = {
--                 autoImportCompletions = true,
--             },
--         },
--     },
-- }

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        virtual_text = false,
        underline = false,
        signs = true,
    }
)
