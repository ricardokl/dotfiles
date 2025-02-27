
local INFO = vim.log.levels.INFO
local ERROR = vim.log.levels.ERROR
local uv = vim.uv
local utils = require('aichat.utils')

local M = {}

function M.run_aichat_job(input, flags)
  local cmd_args = {}

  if flags.mode_flag and flags.mode_arg then
    table.insert(cmd_args, flags.mode_flag)
    table.insert(cmd_args, flags.mode_arg)
  end

  for _, flag in ipairs({'rag', 'session'}) do
    if flags[flag] then
      table.insert(cmd_args, '--' .. flag)
      table.insert(cmd_args, flags[flag])
    end
  end

  local output = ""
  local done = false
  local stdin = uv.new_pipe()
  local stdout = uv.new_pipe()
  local stderr = uv.new_pipe()

  uv.spawn("aichat", {
    args = cmd_args, 
    stdio = {stdin, stdout, stderr}
  }, function()
    stdout:read_stop()
    stderr:read_stop()
    done = true
    if output ~= "" then
      vim.notify("Response from aichat received", INFO)
    end
  end)

  uv.write(stdin, input, function(err)
    vim.notify("Sending input to aichat...", INFO)
    if err then
      vim.notify("Error writing to stdin: " .. err, ERROR)
    end
    uv.shutdown(stdin)
  end)

  uv.read_start(stdout, function(err, data)
    if err then
      vim.notify("Stdout read err: " .. err, ERROR)
    end
    if data then
      output = output .. tostring(data)
    end
  end)

  uv.read_start(stderr, function(err, data)
    if err then
      vim.notify("Stderr read err: " .. err, ERROR)
    end
    if data then
      vim.notify("Stderr DATA: " .. vim.inspect(data), ERROR)
    end
  end)

  local success = vim.wait(50000, function() return done end, 50)
  if not success then
    vim.notify("aichat process timed out", ERROR)
  end
  return utils.extract_content(output)
end

return M

