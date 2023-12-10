-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			vim.cmd("colorscheme catppuccin-macchiato")
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter",
	}, { run = ":TSUpdate" })

	use({ "nvim-treesitter/playground" })
	-- Harpoon Buffer cool
	use({ "theprimeagen/harpoon" })

	--Undo Tree
	use({ "mbbill/undotree" })

	-- Git Integration
	use({ "tpope/vim-fugitive" })

	-- Nerdtree
	use({ "scrooloose/nerdtree" })
	use({ "ryanoasis/vim-devicons" })

	-- Toggle Terminal
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup()
		end,
	})

	-- LSP conifgs
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		requires = {
			--- Uncomment these if you want to manage LSP servers from neovim
			-- {'williamboman/mason.nvim'},
			-- {'williamboman/mason-.nvim'},

			-- LSP Support
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },

			{ "L3MON4D3/LuaSnip" },
			{ "neovim/nvim-lspconfig" },
			{ "windwp/nvim-autopairs" },
			{ "creativenull/efmls-configs-nvim" },
		},
	})
end)
