return {
	"echasnovski/mini.nvim",
	version = false, -- Sempre usa a última versão
	config = function()
		require("mini.icons").setup() -- Ativa mini.icons
	end,
}
