require("mason").setup()
local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
    ensure_installed = { "pyright", "clangd", "jdtls" },
})

local capabilities = cmp_nvim_lsp.default_capabilities()


local on_attach = function(client, bufnr)
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    -- Mappings.
    local opts = { 
        buffer = bufnr, 
        noremap=true, 
        silent=true 
    }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>ge", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>gk", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>gn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<space>w", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
    vim.keymap.set("n", "<space>f", vim.lsp.buf.format, opts)

end

-- Python Setting 
lspconfig.ruff.setup({})
lspconfig.pyright.setup{
  capabilities = capabilities,
  on_attach = on_attach
}

-- C++ Setting 
lspconfig.clangd.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "clangd",
    "--header-insertion=iwyu",
    "--header-insertion-decorators=0",
    "--clang-tidy",
    "--background-index",
    "--compile-commands-dir=."},
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
}

local function organize_imports()
  local params = vim.lsp.util.make_range_params()
  params.context = {
    only = {
      "source.organizeImports",
      "source.removeUnusedImports",
      "source.addMissingImports",
    },
    diagnostics = {},
  }

  local results = vim.lsp.buf_request_sync(
    0,
    "textDocument/codeAction",
    params,
    1000
  )

  if not results then
    return
  end

  for _, res in pairs(results) do
    for _, action in pairs(res.result or {}) do
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
      end

      if action.command then
        vim.lsp.buf.execute_command(action.command)
      end
    end
  end
end



vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = {"*.cpp", "*.hpp", "*.cc", "*.h", "*.py", "*.java"},
    callback = function()
        pcall(organize_imports)
        vim.lsp.buf.format({async = false, timeout_ms=2000})
    end,
})
