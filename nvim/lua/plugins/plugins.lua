return {
   {
	'williamboman/mason.nvim',
    	config = function()
      		require('mason').setup({
			ui = {
        		icons = {
            			package_installed = "✓",
            			package_pending = "➜",
            			package_uninstalled = "✗"
        		}
    			}
		})
	end
    },
    {
    	'williamboman/mason-lspconfig.nvim',
    	config = function()
      		require('mason-lspconfig').setup({
        	ensure_installed = { "pyright" } -- Ensure Pyright is installed
      		})
    	end
    },
    -- Bufferline
    {
        'akinsho/bufferline.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
    },

    -- Colorscheme
    {
        'folke/tokyonight.nvim',
    },
    {'navarasu/onedark.nvim'},
    { 'morhetz/gruvbox' },
    { 'joshdick/onedark.vim' },
    { 'arcticicestudio/nord-vim' },

    -- Lualine
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
    },

    -- Nvimtree (File Explorer)
    {"nvim-tree/nvim-web-devicons"},
    -- Added this reference to the initial file
    {
        'nvim-tree/nvim-tree.lua',
        lazy = true,
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
    },

    -- Which-key
    {
        'folke/which-key.nvim',
        lazy = true,
    },
    {
    	"neovim/nvim-lspconfig",
    },
    { 'akinsho/toggleterm.nvim'},
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-vsnip" },
    { "hrsh7th/vim-vsnip" },
}
