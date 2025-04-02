-- return {
--   "olimorris/onedarkpro.nvim",
--   priority = 1000,
--   config = function()
--     vim.cmd("colorscheme onedark")
--   end
-- }
return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		vim.cmd("colorscheme catppuccin-mocha")
	end,
	integrations = {
		barbar = true,
		alpha = true,
		gitsigns = true,
		mason = true,
		neotree = true,
		cmp = true,
		telescope = {
			enabled = true,
			style = "nvchad",
		},
		which_key = true,
	},
}
