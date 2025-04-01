local ensure_installed = { "lua_ls", "pyright", "gopls", "rust_analyzer", "ruff", "pylsp" }

local function get_python_executable()
	local venv_path = os.getenv("VIRTUAL_ENV")
	if venv_path then
		return venv_path .. "/bin/python"
	else
		return "python" -- Default to system python if VIRTUAL_ENV is not set
	end
end

local function set_pyright_config(opts)
	opts.before_init = function(params)
		params.processId = vim.NIL
		params.rootPath = vim.fn.getcwd()
		params.rootUri = vim.uri_from_fname(vim.fn.getcwd())
		params.initializationOptions = { pythonPath = get_python_executable() }
	end

	opts.settings = {
		python = {
			pythonPath = get_python_executable(),
			typeCheckingMode = "off",
			analyzeUnannotatedFunctions = false,
			reportReturnType = false,
			diagnosticMode = "openFilesOnly",
			useLibraryCodeForTypes = true,
		},
	}
end

local function set_gopls_config(opts)
	opts.settings = {
		gopls = {
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	}
end

local function set_lua_ls_config(opts)
	opts.settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }, -- Diz ao LSP que "vim" é uma variável global
			},
			workspace = {
				library = {
					vim.fn.expand("$VIMRUNTIME/lua"), -- Inclui as libs internas do Neovim
					vim.fn.stdpath("config") .. "/lua",
				},
			},
			telemetry = { enable = false },
		},
	}
end

local function set_pylsp_config(opts)
	opts.settings = {
		pylsp = {
			plugins = {
				pylsp_mypy = {
					enabled = true,
					overrides = { "--python-executable", get_python_executable(), true, "--disallow-untyped-calls" },
					report_progress = true,
					live_mode = true,
					strict = true,
				},
			},
		},
	}
end

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "hrsh7th/cmp-nvim-lsp" }, -- Integração com CMP
		config = function()
			local lspconfig = require("lspconfig")
			local signature = require("lsp.signature")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local on_attach = function(client, bufnr)
				local opts = { buffer = bufnr, remap = false }
				local map = vim.keymap.set

				map("n", "gd", vim.lsp.buf.definition, opts)
				map("n", "K", vim.lsp.buf.hover, opts)
				map(
					"n",
					"<leader>vw",
					vim.lsp.buf.workspace_symbol,
					{ desc = "Search symbol in [W]orkspace", buffer = bufnr, remap = false }
				)
				map(
					"n",
					"<leader>vd",
					vim.diagnostic.open_float,
					{ desc = "[V]iew [D]iagnostics", buffer = bufnr, remap = false }
				)
				map("n", "[d", vim.diagnostic.goto_next, opts)
				map("n", "]d", vim.diagnostic.goto_prev, opts)
				map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				map("n", "gr", vim.lsp.buf.references, opts)
				map("n", "<leader>vr", require("lsp.renamer"), { desc = "[R]ename", buffer = bufnr, remap = false })

				signature.setup(client, bufnr)
			end

			-- Configuração global de diagnósticos
			vim.diagnostic.config({
				virtual_text = true, -- Exibe erro inline
				signs = true, -- Mostra ícones na lateral
				underline = true,
				update_in_insert = false,
				float = { border = "rounded" },
			})

			-- Lista de servidores LSP para instalar
			local servers = ensure_installed
			for _, server in ipairs(servers) do
				lspconfig[server].setup({
					on_attach = on_attach,
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
				})
			end

			-- Configuração para cada servidor
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					local opts = {
						on_attach = on_attach,
						capabilities = capabilities,
					}

					-- Specific configs
					if server_name == "lua_ls" then
						set_lua_ls_config(opts)
					end
					if server_name == "gopls" then
						set_gopls_config(opts)
					end
					if server_name == "pyright" then
						set_pyright_config(opts)
					end

					if server_name == "pylsp" then
						set_pylsp_config(opts)
					end

					-- Aplica configuração específica por LSP
					lspconfig[server_name].setup(opts)
				end,
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = ensure_installed,
			})
		end,
	},
}
