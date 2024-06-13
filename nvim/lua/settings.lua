vim.g.mapleader = " "
vim.cmd("set expandtab")
vim.cmd("set shiftwidth=2")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set colorcolumn=80,120")
vim.cmd("set clipboard+=unnamedplus")
vim.cmd("set smartindent")
vim.g.python3_host_prog = '/Users/tamer.cuba/.pyenv/shims/python3'
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 15
vim.opt.signcolumn = "yes"
vim.opt.breakindent = true

-- auto add closing {, [, (, ', "
vim.keymap.set('i', '{<cr>', '{<cr>}<ESC>kA<CR>', {})
local closing_pairs = { '}', ')', ']', '"', "'" }
local opening_pairs = { '{', '(', '[', '"', "'" }
for key, chr in pairs(opening_pairs)
do
  vim.keymap.set('i', chr, chr .. closing_pairs[key] .. '<esc>i', {})
end

-- Control (^) + j/k to move line up/down
vim.keymap.set('n', '<c-K>', 'yyddkP') -- DOWN
vim.keymap.set('n', '<c-J>', 'yyddp')  -- UP


-- H/L To go to begin/end of line
vim.keymap.set('n', 'H', '_')
vim.keymap.set('n', 'L', '$')
