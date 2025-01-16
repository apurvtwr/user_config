require("mason").setup()
lspconfig = require("lspconfig")
cmp_nvim_lsp = require("cmp_nvim_lsp")
mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
    ensure_installed = { "pyright", "clangd" },
})

capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig.pyright.setup{
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local buf_set_keymap = vim.api.nvim_buf_set_keymap
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap(bufnr, 'n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap(bufnr, 'n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap(bufnr, 'n', '<space>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap(bufnr, 'n', '<space>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap(bufnr, 'n', '<space>wl', '<Cmd>lua vim.lsp.buf.list_workspace_folders()<CR>', opts)
    buf_set_keymap(bufnr, 'n', '<space>D', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap(bufnr, 'n', '<space>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap(bufnr, 'n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap(bufnr, 'n', '<space>e', '<Cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap(bufnr, 'n', '[d', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap(bufnr, 'n', ']d', '<Cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap(bufnr, 'n', '<space>q', '<Cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    buf_set_keymap(bufnr, 'n', '<space>f', '<Cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    end,
}

lspconfig.clangd.setup{
  capabilities = capabilities,
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
}
vim.lsp.set_log_level("error")
