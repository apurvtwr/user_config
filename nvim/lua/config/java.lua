local jdtls = require("jdtls")
local jdtls_setup = require("jdtls.setup")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local root_dir = jdtls_setup.find_root({
  ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", "settings.gradle",
})
if not root_dir then
  return
end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

local jdtls_cmd = vim.fn.stdpath("data") .. "/mason/bin/jdtls"

-- Optional: debug + test bundles (install via Mason: java-debug-adapter, java-test)
local mason_packages = vim.fn.stdpath("data") .. "/mason/packages/"
local bundles = {}

local java_debug = vim.fn.glob(
  mason_packages .. "java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
  1
)
if java_debug ~= "" then
  table.insert(bundles, java_debug)
end

local java_test_bundles = vim.fn.glob(mason_packages .. "java-test/extension/server/*.jar", 1)
if java_test_bundles ~= "" then
  for _, jar in ipairs(vim.split(java_test_bundles, "\n")) do
    if jar ~= "" then table.insert(bundles, jar) end
  end
end

local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>oi",
    "<Cmd>lua require('jdtls').organize_imports()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>tc",
    "<Cmd>lua require('jdtls').test_class()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>tn",
    "<Cmd>lua require('jdtls').test_nearest_method()<CR>", opts)

  jdtls.setup_dap({ hotcodereplace = "auto" })
end

jdtls.start_or_attach({
  cmd = { jdtls_cmd, "-data", workspace_dir },
  root_dir = root_dir,
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = { bundles = bundles },
  settings = {
    java = {
      format = { enabled = true },
      configuration = { updateBuildConfiguration = "interactive" },
    },
  },
})
