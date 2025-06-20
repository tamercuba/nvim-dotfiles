vim.keymap.set("n", "<c-l>", ":wincmd l<CR>", { desc = "Go to right table" })
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>", { desc = "Go to left table" })
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>", { desc = "Go to upper table" })
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>", { desc = "Go to bottom table" })
vim.keymap.set("n", "<C-\\>", ":vsplit<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-|>", ":split<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-k>", [[<C-\><C-n><C-w>k]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-j>", [[<C-\><C-n><C-w>j]], { noremap = true, silent = true })
