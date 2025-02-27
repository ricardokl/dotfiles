local vim = vim
local api = vim.api
local config = require("aichat.config")
local job_runner = require("aichat.job_runner")

local M = {}

local function create_aichat_command(default_role, post_process)
  return function(opts)
    local bufnr = api.nvim_get_current_buf()
    local start_line = opts.line1 or 1
    local end_line = opts.line2 or api.nvim_buf_line_count(bufnr)
    local lines = api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)
    local code = table.concat(lines, "\n")

    local flags = config.parse_args(opts.fargs or {})
    flags.mode_flag = flags.mode_flag or "--role"
    flags.mode_arg = flags.mode_arg or default_role

    local ft = vim.bo.filetype or ''
    vim.ui.input({ prompt = 'Aichat: ', default = '' }, function(input)
      if input ~= '' then input = input .. '\n' end
      local full_input = input .. ('```%s\n%s\n```'):format(ft, code)

      local output = job_runner.run_aichat_job(full_input, flags)
      if post_process then output = post_process(output) end

      api.nvim_buf_set_lines(bufnr, start_line - 1, end_line, false, vim.split(output, "\n"))
      vim.lsp.buf.format()
    end)
  end
end

function M.setup()
  -- Commands
  api.nvim_create_user_command("AichatSet", function(opts)
    local ok, err = pcall(config.set_config_from_args, opts.fargs)
    vim.notify(ok and "Aichat flags updated" or ("Error setting flags: " .. err),
               ok and vim.log.levels.INFO or vim.log.levels.ERROR)
  end, { nargs = "+", desc = "Set Aichat flags (e.g. --role assistant --rag myrag)" })

  api.nvim_create_user_command("Aichat", create_aichat_command("1filecoder"),
    { range = "%", nargs = "*", desc = "Run aichat with selected content" })

  api.nvim_create_user_command("AichatPipe", create_aichat_command("o3architect", function(output)
    return job_runner.run_aichat_job(output, {"--role", "1filecoder"})
  end), { range = "%", nargs = "*", desc = "Pipe through 1filecoder" })

  -- Keymaps
  local keymaps = {
    { mode = 'v', lhs = '<leader>as', rhs = ":'<,'>Aichat<CR>", desc = "Run aichat" },
    { mode = 'n', lhs = '<leader>as', rhs = ":Aichat<CR>", desc = "Run aichat" },
    { mode = 'v', lhs = '<leader>ap', rhs = ":'<,'>AichatPipe<CR>", desc = "Run piped aichat" },
    { mode = 'n', lhs = '<leader>ap', rhs = ":AichatPipe<CR>", desc = "Run piped aichat" },
  }

  for _, map in ipairs(keymaps) do
    api.nvim_buf_set_keymap(0, map.mode, map.lhs, map.rhs, {
      noremap = true,
      silent = true,
      desc = map.desc
    })
  end
end

return M
