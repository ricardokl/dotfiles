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
    map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', "Find implementations")
    map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', "Find references")
    map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', "Hover")
    map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', "Signature help")
    map('v', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', "LSP Format")
    map('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', "Rename")
    map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', "Code actions")
    map('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', "Diagnostics float")
    map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', "Goto next diagnostic")
    map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', "Goto previous diagnostic")
  end
})
--}}}

--{{{ Movendo nos splits
local function splits_map(a, b, d)
  vim.api.nvim_set_keymap('n', a, b, vim.tbl_extend(
    'keep', { noremap = true }, { desc = d }
  ))
end

splits_map('<c-h>', '<cmd>NavigatorLeft<cr>', "navigator move left")
splits_map('<c-j>', '<cmd>NavigatorDown<cr>', "navigator move down")
splits_map('<c-k>', '<cmd>NavigatorUp<cr>', "navigator move up")
splits_map('<c-l>', '<cmd>NavigatorRight<cr>', "navigator move right")
splits_map('<c-p>', '<cmd>NavigatorPrevious<cr>', "navigator move previous")
splits_map('<c-left>', '<c-w>h', "move to split left")
splits_map('<c-down>', '<c-w>j', "move to split down")
splits_map('<c-up>', '<c-w>k', "move to split up")
splits_map('<c-right>', '<c-w>l', "move to split right")
--}}}

--{{{ Movendo entre bufers
vim.api.nvim_set_keymap('n', '[b', ':bprevious<cr>', { silent = true })
vim.api.nvim_set_keymap('n', ']b', ':bnext<cr>', { silent = true })
--}}}

--{{{ Telescope
vim.api.nvim_set_keymap('n', '<Space>ff', ':Telescope find_files<cr>', {})
vim.api.nvim_set_keymap('n', '<Space>fd', ':Telescope fd<cr>', {})
vim.api.nvim_set_keymap('n', '<Space>fl', ':Telescope loclist<cr>', {})
vim.api.nvim_set_keymap('n', '<Space>fb', ':Telescope buffers<cr>', {})
--}}}
