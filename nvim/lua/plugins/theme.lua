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
}
