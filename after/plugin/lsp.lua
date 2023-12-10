local lsp = require("lsp-zero")
local lspconfig = require("lspconfig")
local mason_config = require("mason-lspconfig")
local mason = require("mason")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

lsp.preset("recommended")

mason.setup({})

mason_config.setup({
	ensure_installed = { "efm", "tsserver", "eslint", "intelephense" },
	automatic_installaion = true,
})

local capabilities = cmp_nvim_lsp.default_capabilities()
-- Lua Settup
lspconfig.lua_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				libraty = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

-- Typescript Config
lspconfig.tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
})

-- PHP Config
lspconfig.intelephense.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = {
		"php",
	},
	root_dir = function(pattern)
		local cwd = vim.loop.cwd()
		local root = lspconfig.util.root_pattern("composer.json", ".git")(pattern)

		-- prefer cwd if root is a descendant
		-- return lspconfig.util.path.is_descendant(cwd, root) and cwd or root
		return cwd
	end,
})

-- local luacheck = require("efmls-configs.linters.luacheck")
local stylua = require("efmls-configs.formatters.stylua")
local eslint_d = require("efmls-configs.linters.eslint_d")
local prettierd = require("efmls-configs.formatters.prettier_d")
local phpstan = require("efmls-configs.linters.phpstan")

lspconfig.efm.setup({
	filetypes = {
		"lua",
		"typescript",
		"php",
	},
	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
		hover = true,
		documentSymbol = true,
		codeAction = true,
		completion = true,
	},
	settings = {
		languages = {
			lua = { stylua },
			typescript = { eslint_d, prettierd },
			php = { phpstan },
		},
	},
})

local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingsGroup", {})
vim.api.nvim_create_autocmd("BufWritePost", {
	group = lsp_fmt_group,
	callback = function()
		local efm = vim.lsp.get_active_clients({ name = "efm" })

		if vim.tbl_isempty(efm) then
			return
		end

		vim.lsp.buf.format({ name = "efm" })
	end,
})

lsp.setup()
