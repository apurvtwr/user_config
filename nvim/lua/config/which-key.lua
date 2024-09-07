local wk = require("which-key")
wk.add({
  { "<leader>f", group = "file" }, -- group
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
  { "<C-n>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle Tree"},
  { "<C-p>", "<cmd>Lazy<cr>", desc="Lazy Package Manager"},
  { "<C-m>", "<cmd>Mason<cr>", desc="Mason Package Manager"},
  {"<C-l>", "<cmd>BufferLineCycleNext<cr>", desc="Next Tab"},
  {"<C-h>", "<cmd>BufferLineCyclePrev<cr>", desc="Prev Tab"},
  {"<C-\\>", "<cmd>ToggleTerm<cr>", desc="Floating Terminal"},
  {
    -- Nested mappings are allowed and can be added in any order
    -- Most attributes can be inherited or overridden on any level
    -- There's no limit to the depth of nesting
    mode = { "n", "v" }, -- NORMAL and VISUAL mode
    { "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
    { "<leader>w", "<cmd>w<cr>", desc = "Write" },
  }
})
