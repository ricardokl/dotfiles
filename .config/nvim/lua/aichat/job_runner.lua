local INFO = vim.log.levels.INFO
local ERROR = vim.log.levels.ERROR
local uv = vim.uv
local utils = require('aichat.utils')

local M = {}

function M.run_aichat_job(input, flags)
  local cmd = "aichat"
  local cmd_args = {}

  if flags.mode_flag and flags.mode_arg then
    table.insert(cmd_args, flags.mode_flag)
    table.insert(cmd_args, flags.mode_arg)
  end

  if flags.rag then
    table.insert(cmd_args, '--rag')
    table.insert(cmd_args, flags.rag)
  end

  if flags.session then
    table.insert(cmd_args, '--session')
    table.insert(cmd_args, flags.session)
  end

  local output, done = "", false
  local stdin = uv.new_pipe()
  local stdout = uv.new_pipe()
  local stderr = uv.new_pipe()

  local handle, pid = uv.spawn(cmd, {
    args = cmd_args, stdio = {stdin, stdout, stderr},
  -- local handle, pid = uv.spawn("cat", {
  --   stdio = {stdin, stdout, stderr}
  }, function()
      stdout:read_stop()
      stderr:read_stop()
      done = true
      if output ~= "" then
        vim.notify("Response from aichat recieved", INFO)
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
      vim.notify("Stdout read err: "..err, ERROR)
    end
    if data then
      output = output..tostring(data)
    end
  end)

  uv.read_start(stderr, function(err, data)
    if err then
      vim.notify("Stdout read err: "..err, ERROR)
    end
    if data then
      vim.notify("Stderr DATA: "..vim.inspect(data), ERROR)
    end
  end)

  local success = vim.wait(50000, function() return done end, 50)
  if not success then
    vim.notify("aichat process timed out", ERROR)
  end
  return utils.extract_content(output)
end

return M
