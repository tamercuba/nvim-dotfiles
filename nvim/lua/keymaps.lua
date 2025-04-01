vim.keymap.set('n', '<c-l>', ':wincmd l<CR>', { desc = 'Go to right table' })
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>', { desc = 'Go to left table' })
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>', { desc = 'Go to upper table' })
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>', { desc = 'Go to bottom table' })
-- vim.keymap.set('n', '<C-\\>', ':vsplit<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-\\>', ':split<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ot', ':ToggleTerm<CR>', { desc = '[O]pen [T]erminal', noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-k>', [[<C-\><C-n><C-w>k]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-j>', [[<C-\><C-n><C-w>j]], { noremap = true, silent = true })



-- Barbar
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
map('n', '<A-C>', '<Cmd>BufferCloseAllButCurrent<CR>', opts)
map('n', '<BS>', 'ciw', opts)
