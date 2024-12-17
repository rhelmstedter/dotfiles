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
keymap("i", "<C-h>", vim.lsp.buf.signature_help, s_opts)
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

keymap("n", "<leader>fm", function()
    require("telescope.builtin").lsp_document_symbols({ symbols = { "method", "function" } })
end, {})
-- Setup lspconfig for autocompletion.
local capabilities = require("cmp_nvim_lsp").default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)
local servers = {
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
require 'lspconfig'.lua_ls.setup {}
require('lspconfig').pylsp.setup {
    flags = {},
    settings = {
        -- configure plugins in pylsp
        pylsp = {
            plugins = {
                pyflakes = { enabled = true },
                pylint = { enabled = false },
                rope_autoimport = { enabled = true },
            },
        },
    },
}

-- Configure `ruff-lsp`.
local configs = require 'lspconfig.configs'
if not configs.ruff_lsp then
    configs.ruff_lsp = {
        default_config = {
            cmd = { 'ruff-lsp' },
            filetypes = { 'python' },
            root_dir = require('lspconfig').util.find_git_ancestor,
            init_options = {
                settings = {
                    args = {}
                }
            }
        }
    }
end

require('lspconfig').ruff_lsp.setup {}

require("lspconfig").ltex.setup({
    settings = {
        ltex = {
            language = "en",
            additionalRules = {
                languageModel = "~/models/ngrams/",
            },
        },
    },
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        virtual_text = false,
        underline = false,
        signs = true,
    }
)
