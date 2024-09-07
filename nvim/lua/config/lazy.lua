-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
  -- Theme plugins
  { 'morhetz/gruvbox' },
  { 'joshdick/onedark.vim' },
  { 'arcticicestudio/nord-vim' },
  { 'folke/tokyonight.nvim' },
  { 'navarasu/onedark.nvim'}
})


local themes = {
  'gruvbox',
  'onedark',
  'nord',
  'tokyonight',
  -- Add more themes here if needed
}

-- Function to pick a theme
local function pick_theme()
  local current_theme = vim.g.colors_name
  local next_theme_index = 1

  for i, theme in ipairs(themes) do
    if theme == current_theme then
      next_theme_index = i % #themes + 1
      break
    end
  end

  local next_theme = themes[next_theme_index]
  vim.cmd('colorscheme ' .. next_theme)
  print('Switched to ' .. next_theme)
end

-- Command to pick a theme
vim.api.nvim_create_user_command('PickTheme', pick_theme, {})
vim.api.nvim_set_keymap('n', '<leader>th', ':PickTheme<CR>', { noremap = true, silent = true })
