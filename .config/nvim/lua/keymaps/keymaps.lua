vim.g.mapleader = ' '
--{{{ Movendo nos splits
vim.api.nvim_set_keymap('n', '<c-h>', '<c-w>h', { noremap = true})
vim.api.nvim_set_keymap('n', '<c-j>', '<c-w>j', { noremap = true})
vim.api.nvim_set_keymap('n', '<c-k>', '<c-w>k', { noremap = true})
vim.api.nvim_set_keymap('n', '<c-l>', '<c-w>l', { noremap = true})
vim.api.nvim_set_keymap('n', '<c-Left>', '<c-w>h',{ noremap = true})
vim.api.nvim_set_keymap('n', '<c-Down>', '<c-w>j',{ noremap = true})
vim.api.nvim_set_keymap('n', '<c-Up>', '<c-w>k',{ noremap = true})
vim.api.nvim_set_keymap('n', '<c-Right>', '<c-w>l',{ noremap = true})
--}}}

--{{{ Movendo entre bufers
vim.api.nvim_set_keymap('n', '[b', ':bprevious<cr>',{ silent = true })
vim.api.nvim_set_keymap('n', ']b', ':bnext<cr>',{ silent = true })
--}}}

--{{{ Telescope
vim.api.nvim_set_keymap('n', '<Space>ff', ':Telescope find_files<cr>',{})
vim.api.nvim_set_keymap('n', '<Space>fd', ':Telescope fd<cr>',{})
vim.api.nvim_set_keymap('n', '<Space>fl', ':Telescope loclist<cr>',{})
vim.api.nvim_set_keymap('n', '<Space>bb', ':Telescope buffers<cr>',{})
--}}}

