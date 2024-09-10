require("mason").setup()
lspconfig = require("lspconfig")
cmp_nvim_lsp = require("cmp_nvim_lsp")
mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
    ensure_installed = { "pyright" },
})

capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig.pyright.setup{
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    end,
}

vim.lsp.set_log_level("debug")
