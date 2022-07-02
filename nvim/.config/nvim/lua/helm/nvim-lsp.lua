vim = vim -- avoid lsp warnings

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
local refs = "<cmd>lua require'telescope.builtin'.lsp_references(require('telescope.themes').get_dropdown({layout = 'vertical', layout_config= {height = 0.4, width = 0.8 }}))<cr>"

require("nvim-lsp-installer").setup({
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
keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
-- LSP Mappings.
keymap("n", "gD", vim.lsp.buf.declaration, opts)
keymap("n", "gd", vim.lsp.buf.definition, opts)
keymap("n", "K", vim.lsp.buf.hover, opts)
keymap("n", "gi", vim.lsp.buf.implementation, opts)
keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)
keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
keymap("n", "<leader>D", vim.lsp.buf.type_definition, opts)
keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
keymap("n", "gr", refs, opts)
keymap("n", "<leader>f", vim.lsp.buf.format, opts)
keymap(
    "n",
    "<leader>wl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    {}
)

-- Setup lspconfig for autocompletion.
local capabilities = require("cmp_nvim_lsp").update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)
local servers = {
    "pylsp",
    "sumneko_lua",
    "tailwindcss",
    "bashls",
}

for _, lsp in pairs(servers) do
    require("lspconfig")[lsp].setup {
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        },
        no_wait = true,
    }
end

-- pyright is only used for auto import; turned off everything else
require("lspconfig")["pyright"].setup{
    capabilities = capabilities,
    handlers = {
        ['textDocument/publishDiagnostics'] = function(...) end
    },
    settings = {
        typeCheckingMode = 'off',
        python = {
            analysis = {
                typeCheckingMode = 'off',
            },
        },
        pyright = {
            disableDiagnostics = true,
        },
    }
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        virtual_text = false,
        underline = false,
        signs = true,
    }
)

