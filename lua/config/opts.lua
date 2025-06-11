vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.o.autoread = true
vim.cmd("set expandtab")
vim.cmd("set shiftwidth=2")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set colorcolumn=80,120")
vim.cmd("set clipboard+=unnamedplus")
vim.cmd("set smartindent")
vim.cmd("set laststatus=2")
vim.g.python3_host_prog = "/Users/tamer.cuba/.pyenv/shims/python3"
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 15
vim.opt.signcolumn = "yes"
vim.opt.breakindent = true

vim.keymap.set("n", "<leader>j", "yyddp", { desc = "Move line UP" })
vim.keymap.set("n", "<leader>k", "yyddkP", { desc = "Move Line Down" })

-- H/L To go to begin/end of line
vim.keymap.set("n", "H", "_")
vim.keymap.set("n", "L", "$")

vim.diagnostic.config({
	virtual_text = {
		prefix = "●", -- Pode ser qualquer caractere
		source = "always", -- Inclui o nome do LSP
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		source = "always", -- Inclui o nome do LSP
	},
})

