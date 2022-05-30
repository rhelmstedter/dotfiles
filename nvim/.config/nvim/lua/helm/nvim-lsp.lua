vim = vim -- avoid lsp warnings

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
local refs =
"<cmd>lua require'telescope.builtin'.lsp_references(require('telescope.themes').get_dropdown({layout = 'vertical', layout_config= {height = 0.4, width = 0.8 }}))<cr>"
-- "<cmd>lua require'telescope.builtin'.lsp_references()<cr>"

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
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
vim.keymap.set("n", "gr", refs, opts)
vim.keymap.set("n", "<leader>f", vim.lsp.buf.formatting, opts)
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
    -- "pyright",
    "sumneko_lua",
    "tailwindcss",
    "bashls",
}

-- loop over the severs table and attach
for _, lsp in pairs(servers) do
    require("lspconfig")[lsp].setup {
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        },
    }
end

-- Diagnostics for LSP
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
    virtual_text = false,
    underline = false,
    signs = true,
}
)

