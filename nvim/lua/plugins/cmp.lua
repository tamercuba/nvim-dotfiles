return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"onsails/lspkind.nvim", -- Ícones estilizados
	},
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind") -- Ícones personalizados

		cmp.setup({
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text", -- Mostra ícone + texto
					preset = "codicons",
					maxwidth = 50, -- Limita largura
					ellipsis_char = "...", -- Usa "..." para cortar
					show_labelDetails = true,
				}),
			},
			window = {
				completion = cmp.config.window.bordered(), -- Bordas estilizadas
				documentation = cmp.config.window.bordered(),
			},
			experimental = {
				ghost_text = true, -- Exibe sugestões fantasmas no fundo
			},
			-- snippet = {
			-- 	expand = function(args)
			-- 		require("luasnip").lsp_expand(args.body)
			-- 	end,
			-- },
			mapping = cmp.mapping.preset.insert({
				["<Tab>"] = cmp.mapping.select_next_item(),
				["<S-Tab>"] = cmp.mapping.select_prev_item(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "conjure" },
				{ name = "ts_ls" },
				{ name = "nvim_lsp" },
				{ name = "buffer" },
				{ name = "path" },
				{ name = "luasnip" },
			}),
		})
	end,
}
