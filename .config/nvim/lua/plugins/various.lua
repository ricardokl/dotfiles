return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown", "Avante" },
    },
    ft = { "markdown", "Avante" },
  },

  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },

  {
    "jiangmiao/auto-pairs",
  },

  {
    "numToStr/Navigator.nvim",
    config = function()
      require('Navigator').setup({})
    end
  },

  {
    "nvim-lua/plenary.nvim",
    lazy = false,
    config = function()
      local Job = require("plenary.job")

      local function extract_content(output)
        if #output == 0 then
          return output
        end
        if output[1]:sub(1, 3) == "```" then
          table.remove(output, 1)
          if #output > 0 and output[#output]:sub(1, 3) == "```" then
            table.remove(output, #output)
          end
        end
        return output
      end

      local function parse_args(args)
        local flag, chatArgs = "", ""
        local i = 1
        while i <= #args do
          if args[i] == "-f" then
            flag = args[i + 1] or ""
            i = i + 2
          else
            chatArgs = chatArgs .. args[i] .. " "
            i = i + 1
          end
        end
        return vim.trim(chatArgs), flag
      end

      local function run_aichat_job(input, chatArgs, flag, callback)
        local jobArgs = {}
        if flag ~= "" then
          table.insert(jobArgs, "-f")
          table.insert(jobArgs, flag)
        end
        table.insert(jobArgs, "-r")
        table.insert(jobArgs, chatArgs)
        local filetype = vim.bo.filetype or ""
        local user_input = vim.fn.input("Enter input: ")
        local wrapped_input = user_input .. "\n```" .. filetype .. "\n" .. input .. "\n```"
        Job:new({
          command = "aichat",
          args = jobArgs,
          writer = wrapped_input,
          on_exit = function(j)
            local result = extract_content(j:result())
            vim.schedule(function()
              callback(result)
            end)
          end,
        }):start()
      end

      local function update_buffer(bufnr, start_line, end_line, result)
        vim.api.nvim_buf_set_lines(bufnr, start_line - 1, end_line, false, result)
        vim.lsp.buf.format()
      end

      vim.api.nvim_create_user_command("Aichat", function(opts)
        local bufnr = vim.api.nvim_get_current_buf()
        local start_line = opts.line1 or 1
        local end_line = opts.line2 or vim.api.nvim_buf_line_count(bufnr)
        local lines = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)
        local input = table.concat(lines, "\n")
        local chatArgs, flag = parse_args(opts.fargs)
        run_aichat_job(input, chatArgs, flag, function(result)
          update_buffer(bufnr, start_line, end_line, result)
        end)
      end, { range = "%", nargs = "*" })
      vim.api.nvim_buf_set_keymap(0, 'v', '<leader>as', '<cmd>Aichat o3coder<CR>',
        { noremap = true, silent = true, desc = "O3coder" })
    end
  },
}
