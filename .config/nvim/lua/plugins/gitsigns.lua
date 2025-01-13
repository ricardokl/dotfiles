return {
  {
    -- "airblade/vim-gitgutter"
  "lewis6991/gitsigns.nvim",
    config = function ()
      require('gitsigns').setup({
        on_attach = function(bufnr)
          local gitsigns = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']h', function()
            if vim.wo.diff then
              vim.cmd.normal({']c', bang = true})
            else
              gitsigns.nav_hunk('next')
            end
          end)

          map('n', '[h', function()
            if vim.wo.diff then
              vim.cmd.normal({'[c', bang = true})
            else
              gitsigns.nav_hunk('prev')
            end
          end)

          -- Actions
          map('n', '<leader>hs', ':Gitsigns stage_hunk<cr>')
          map('n', '<leader>hr', ':Gitsigns reset_hunk<cr>')
          map('n', '<leader>hS', ':Gitsigns stage_buffer<cr>')
          map('n', '<leader>hu', ':Gitsigns undo_stage_hunk<cr>')
          map('n', '<leader>hR', ':Gitsigns reset_buffer<cr>')
          map('n', '<leader>hp', ':Gitsigns preview_hunk<cr>')
          map('n', '<leader>hd', ':Gitsigns diffthis<cr>')
          map('n', '<leader>hD', function() gitsigns.diffthis('~') end)

          -- Text object
          map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end})
    end
  },
}
