require("config.autocmds")
require('config.keymaps')
require('config.opts')
require("config.lazy")
require("aichat_nvim")
vim.cmd.colorscheme("onedark")

vim.diagnostic.config({
  virtual_lines = {
    current_line = true,
  },
  virtual_text = true,
})

vim.lsp.enable({ 'luals', 'pyright', 'ruff', 'vimls', 'rust-analyzer' })

local function tab_complete()
  if vim.fn.pumvisible() == 1 then
    -- navigate to next item in completion menu
    return '<Down>'
  end

  local c = vim.fn.col('.') - 1
  local is_whitespace = c == 0 or vim.fn.getline('.'):sub(c, c):match('%s')

  if is_whitespace then
    -- insert tab
    return '<Tab>'
  end

  local lsp_completion = vim.bo.omnifunc == 'v:lua.vim.lsp.omnifunc'

  if lsp_completion then
    -- trigger lsp code completion
    return '<C-x><C-o>'
  end

  -- suggest words in current buffer
  return '<C-x><C-n>'
end

local function tab_prev()
  if vim.fn.pumvisible() == 1 then
    -- navigate to previous item in completion menu
    return '<Up>'
  end

  -- insert tab
  return '<Tab>'
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspFormatting", {}),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.supports_method("textDocument/formatting") then
      -- Format on save with ruff priority
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = args.buf,
        once = true,
        callback = function()
          vim.lsp.buf.format({
            filter = function(c)
              -- Prefer ruff for formatting
              if c.name == "ruff_lsp" or c.name == "ruff" then
                return true
              end
              -- Fall back to pyright if ruff not available
              return c.name == "pyright"
            end
          })
        end,
      })
    end
  end,
})

-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(ev)
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     if client:supports_method('textDocument/completion') then
--       vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--     end
--
--     if client:supports_method('textDocument/formatting') then
--       vim.api.nvim_create_autocmd('BufWritePre', {
--         buffer = ev.buf,
--         callback = function()
--           vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
--         end,
--       })
--     end
--
--     if client:supports_method('textDocument/inlayHint') then
--       vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
--     end
--   end,
-- })

vim.keymap.set('i', '<Tab>', tab_complete, { expr = true })
vim.keymap.set('i', '<S-Tab>', tab_prev, { expr = true })
