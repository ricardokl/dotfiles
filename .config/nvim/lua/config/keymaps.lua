vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--{{{ LSP Autocommand
vim.api.nvim_create_autocmd('LspAttach', {
  desc = "LSP keybindings",
  callback = function()
    local opts = { noremap = true, silent = true }
    local function map(m, a, b, d)
      vim.api.nvim_buf_set_keymap(0, m, a, b, vim.tbl_extend(
        'keep', opts, { desc = d }
      ))
    end

    map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', "Goto definition")
    map('v', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', "LSP Format")
    map('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', "Diagnostics float")
    map('n', '<leader>cs', '<cmd>Telescope lsp_document_symbols<CR>', "Document symbols")
    map('n', '<leader>cd', '<cmd>Telescope diagnostics<CR>', "Diagnostics")
  end
})
--}}}

--{{{ Movendo nos splits
local function splits_map(a, b, d)
  vim.api.nvim_set_keymap('n', a, b, vim.tbl_extend(
    'keep', { noremap = true }, { desc = d }
  ))
end

splits_map('<c-left>', '<c-w>h', "move to split left")
splits_map('<c-down>', '<c-w>j', "move to split down")
splits_map('<c-up>', '<c-w>k', "move to split up")
splits_map('<c-right>', '<c-w>l', "move to split right")
--}}}

--{{{ Telescope
vim.api.nvim_set_keymap('n', '<Space>ff', '<cmd>Telescope find_files<cr>', {})
vim.api.nvim_set_keymap('n', '<Space>fd', '<cmd>Telescope fd<cr>', {})
vim.api.nvim_set_keymap('n', '<Space>fl', '<cmd>Telescope loclist<cr>', {})
vim.api.nvim_set_keymap('n', '<Space>fb', '<cmd>Telescope buffers<cr>', {})
--}}}

vim.api.nvim_set_keymap('i', '<C-y>', '<cmd>call augment#Accept()<CR>', { silent = true })
