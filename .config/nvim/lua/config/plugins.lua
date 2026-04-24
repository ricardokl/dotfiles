-- Native Package Manager for Neovim 0.12
-- Using vim.pack.add for plugin management

local plugins = {
  -- Completion and Snippets
  { src = 'https://github.com/saghen/blink.cmp' },
  'https://github.com/rafamadriz/friendly-snippets',

  -- AI and Coding Assistant
  'https://github.com/nvim-lua/plenary.nvim',

  -- UI and Enhancement
  'https://github.com/folke/noice.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/folke/snacks.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/folke/which-key.nvim',

  -- Navigation and Search
  { src = 'https://github.com/nvim-telescope/telescope.nvim', branch = '0.1.x' },
  'https://github.com/nvim-telescope/telescope-ui-select.nvim',
  'https://github.com/numToStr/Navigator.nvim',

  -- Treesitter and Text Objects
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',

  -- Git
  'https://github.com/lewis6991/gitsigns.nvim',

  -- Formatting and Linting
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/williamboman/mason.nvim',

  -- Themes and Aesthetics
  'https://github.com/navarasu/onedark.nvim',
  'https://github.com/vimpostor/vim-tpipeline',
  'https://github.com/echasnovski/mini.statusline',
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',

  -- Editing
  'https://github.com/tpope/vim-surround',
  'https://github.com/augmentcode/augment.vim',
}

-- Register and install plugins
vim.pack.add(plugins)

-- Helper to safely call setup
local function setup(name, opts)
  local status_ok, plugin = pcall(require, name)
  if status_ok then
    plugin.setup(opts or {})
    return plugin
  end
  return nil
end

-- Plugin Configurations

-- Blink.cmp
setup('blink', {
  keymap = { preset = 'enter' },
  appearance = { use_nvim_cmp_as_default = true, nerd_font_variant = 'mono' },
  sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
  fuzzy = { implementation = "prefer_rust_with_warning" },
  signature = { enabled = true },
  completion = {
    ghost_text = { show_with_menu = false },
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
  },
})

-- Conform
setup('conform', {
  formatters_by_ft = {
    rust = { "rustfmt", lsp_format = "fallback" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})

-- Gitsigns
setup('gitsigns', {
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end
    -- Navigation
    map('n', ']h', function()
      if vim.wo.diff then vim.cmd.normal({ ']c', bang = true }) else gitsigns.nav_hunk('next') end
    end)
    map('n', '[h', function()
      if vim.wo.diff then vim.cmd.normal({ '[c', bang = true }) else gitsigns.nav_hunk('prev') end
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
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
})

-- Mason
setup('mason')

-- Noice
setup('noice', {
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  presets = {
    long_message_to_split = true,
  },
})

-- Snacks
setup('snacks', {
  words = { enabled = false },
  scope = { enabled = false },
  dashboard = { enabled = false },
  statuscolumn = { enabled = true },
  quickfile = { enabled = true },
  bigfile = { enabled = true },
  scroll = { enabled = true },
  input = { enabled = false },
  indent = {
    enabled = true,
    chunk = {
      enabled = true,
      char = {
        corner_top = "╭", corner_bottom = "╰", horizontal = "─", vertical = "│", arrow = ">",
      },
    },
  },
  notifier = {
    style = "compact",
    enabled = true,
    timeout = 3000,
  },
})
vim.keymap.set('n', '<leader>z', function() Snacks.zen() end, { desc = "Toggle Zen Mode" })
vim.keymap.set('n', '<leader>Z', function() Snacks.zen.zoom() end, { desc = "Toggle Zoom" })
vim.keymap.set('n', '<leader>nh', function() Snacks.notifier.show_history() end, { desc = "Notification History" })
vim.keymap.set('n', '<leader>nd', function() Snacks.notifier.hide() end, { desc = "Dismiss All Notifications" })

-- Telescope
setup('telescope', {
  extensions = {
    ["ui-select"] = { require("telescope.themes").get_dropdown {} }
  }
})
local status_ok, telescope = pcall(require, "telescope")
if status_ok then
  telescope.load_extension("ui-select")
end

-- Treesitter
local ts_status, ts_configs = pcall(require, "nvim-treesitter.configs")
if ts_status then
  ts_configs.setup({
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = { "python", "r", "lua", "latex", "bibtex", "bash", "yaml", "json", "html", "css", "rust", "markdown", "markdown_inline" },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<a-k>",
        node_incremental = "<a-k>",
        node_decremental = "<a-j>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer", ["if"] = "@function.inner", ["ac"] = "@call.outer", ["ic"] = "@call.inner",
          ["aa"] = "@parameter.outer", ["ia"] = "@parameter.inner", ["io"] = "@class.inner", ["ao"] = "@class.outer",
          ["ir"] = "@return.inner", ["ar"] = "@return.outer",
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]f"] = { query = "@function.outer", desc = "Next function" },
          ["]c"] = { query = "@call.outer", desc = "Next call" },
          ["]a"] = { query = "@parameter.inner", desc = "Next argument" },
          ["]o"] = { query = "@class.inner", desc = "Next object" },
          ["]r"] = { query = "@return.inner", desc = "Next return" },
        },
        goto_previous_start = {
          ["[f"] = { query = "@function.outer", desc = "Previous function" },
          ["[c"] = { query = "@call.outer", desc = "Previous call" },
          ["[a"] = { query = "@parameter.inner", desc = "Previous argument" },
          ["[o"] = { query = "@class.inner", desc = "Previous object" },
          ["[r"] = { query = "@return.inner", desc = "Previous return" },
        },
        goto_next_end = {
          ["]F"] = { query = "@function.outer", desc = "Next function end" },
          ["]C"] = { query = "@call.outer", desc = "Next call end" },
          ["]A"] = { query = "@parameter.inner", desc = "Next argument end" },
          ["]O"] = { query = "@class.inner", desc = "Next object end" },
          ["]R"] = { query = "@return.inner", desc = "Next return end" },
        },
        goto_previous_end = {
          ["[F"] = { query = "@function.outer", desc = "Previous function end" },
          ["[C"] = { query = "@call.outer", desc = "Previous call end" },
          ["[A"] = { query = "@parameter.inner", desc = "Previous argument end" },
          ["[O"] = { query = "@class.inner", desc = "Previous object end" },
          ["[R"] = { query = "@return.inner", desc = "Previous return end" },
        },
      },
    },
  })
end

-- OneDark Theme
setup('onedark', {
  style = "dark",
  code_style = {
    functions = "underline",
    variables = "bold"
  }
})

-- Render Markdown
setup('render-markdown', {
  file_types = { "markdown" },
})

-- Navigator
setup('Navigator')
vim.keymap.set('n', '<c-h>', '<cmd>NavigatorLeft<cr>', { desc = "navigator move left" })
vim.keymap.set('n', '<c-j>', '<cmd>NavigatorDown<cr>', { desc = "navigator move down" })
vim.keymap.set('n', '<c-k>', '<cmd>NavigatorUp<cr>', { desc = "navigator move up" })
vim.keymap.set('n', '<c-l>', '<cmd>NavigatorRight<cr>', { desc = "navigator move right" })
vim.keymap.set('n', '<c-p>', '<cmd>NavigatorPrevious<cr>', { desc = "navigator move previous" })

-- Mini Statusline
local mini_status_ok, mini_statusline = pcall(require, "mini.statusline")
if mini_status_ok then
  mini_statusline.setup({
    content = {
      active = function()
        local mode, mode_hl = mini_statusline.section_mode({ trunc_width = 120 })
        local git           = mini_statusline.section_git({ trunc_width = 40 })
        local diagnostics   = mini_statusline.section_diagnostics({ trunc_width = 75 })
        local filename      = mini_statusline.section_filename({ trunc_width = 900 })
        local fileinfo      = mini_statusline.section_fileinfo({ trunc_width = 900 })
        local location      = mini_statusline.section_location({ trunc_width = 900 })
        local search        = mini_statusline.section_searchcount({ trunc_width = 75 })

        return mini_statusline.combine_groups({
          { hl = mode_hl,                 strings = { mode } },
          { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
          '%<',
          { hl = 'MiniStatuslineFilename', strings = { filename } },
          '%=',
          { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
          { hl = mode_hl,                  strings = { search, location } },
        })
      end
    }
  })
end

-- Augment
vim.g.augment_disable_tab_mapping = true
vim.g.augment_workspace_folders = {}

-- Which-Key
setup('which-key', {})
vim.keymap.set('n', '<leader>?', function() require("which-key").show({ global = false }) end, { desc = "Buffer Local Keymaps (which-key)" })
