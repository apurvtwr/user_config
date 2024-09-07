vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.tabstop = 4       -- Number of spaces tabs count for
vim.opt.shiftwidth = 4    -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true  -- Use spaces instead of tabs
vim.opt.colorcolumn = "100"
require("config.lazy")
require("config.nvim-tree-config")
require("config.which-key")
require("config.bufferline-config")
require("config.lualine-config")
require("config.toggleterm-config")
