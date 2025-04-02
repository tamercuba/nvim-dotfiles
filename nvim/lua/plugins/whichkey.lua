return {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function()
		require("which-key").setup({
			ignore_missing = true, -- Oculta warnings sobre mapeamentos antigos
			silent = true,
			disable = { warnings = true },
		})

		require("which-key").register({
			{ "<leader>f", desc = "[F]ind" },
			{ "<leader>g", desc = "[G]it" },
			{ "<leader>v", desc = "LSP" },
			{ "<leader>h", desc = "Git [H]unk", mode = "v", prefix = "" },
		})
	end,
}
