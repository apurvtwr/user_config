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
        	ensure_installed = { "pyright", "black", "isort" } -- Ensure Pyright is installed
      		})
    	end
    },
    {
        "nvim-telescope/telescope.nvim",
        branch="0.1.x",
        dependencies={
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
        }
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies={
            'nvim-lua/plenary.nvim',
        } 
    },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp"
    },

    {"hrsh7th/cmp-nvim-lsp"},
    {"hrsh7th/nvim-cmp"},
    {"hrsh7th/cmp-buffer"},
    {"hrsh7th/cmp-path"},
    {"hrsh7th/vim-vsnip"},
    {"hrsh7th/cmp-vsnip"},
    {"saadparwaiz1/cmp_luasnip"},
    {"onsails/lspkind.nvim"},
    {"neovim/nvim-lspconfig"},
    {"antosha417/nvim-lsp-file-operations", config= true},
    {"folke/neodev.nvim", opts={}},
    { 'j-hui/fidget.nvim',
        tag = 'legacy',
        config = function()
            require('fidget').setup({})
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
    
    { 'akinsho/toggleterm.nvim'},
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate", -- Need to run :TSInstall python cpp
        opts = {
        ensure_installed = { "python", "cpp", "c" }, -- add others if needed
        highlight = { enable = true },
        }
    },
    {
        -- chatgpt code comments
        "robitx/gp.nvim",
    }
}
