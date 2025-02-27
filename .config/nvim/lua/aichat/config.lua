local M = {}

M.aichat_config = {
  mode_flag = nil,
  mode_arg = nil,
  rag = nil,
  session = nil,
}

local function process_args(args, config)
  local i = 1
  while i <= #args do
    local a = args[i]
    if a == "--role" or a == "--agent" or a == "--macro" then
      if config.mode_flag or (M.aichat_config.mode_flag and M.aichat_config.mode_flag ~= a) then
        error("Mutually exclusive flag error: Only one of --role, --agent, or --macro may be provided!")
      end
      if i + 1 > #args then
        error("Flag '" .. a .. "' requires an argument")
      end
      config.mode_flag = a
      config.mode_arg = args[i+1]
      i = i + 2
    elseif a == "--rag" then
      if i + 1 > #args then
        error("Flag '--rag' requires an argument")
      end
      config.rag = args[i+1]
      i = i + 2
    elseif a == "--session" then
      if i + 1 > #args then
        error("Flag '--session' requires an argument")
      end
      config.session = args[i+1]
      i = i + 2
    else
      error("Unknown flag: " .. a)
    end
  end
  return config
end

function M.set_config_from_args(args)
  local config = {}
  config = process_args(args, config)
  if config.mode_flag then
    M.aichat_config.mode_flag = config.mode_flag
    M.aichat_config.mode_arg = config.mode_arg
  end
  if config.rag then
    M.aichat_config.rag = config.rag
  end
  if config.session then
    M.aichat_config.session = config.session
  end
end

function M.parse_args(args)
  local flags = {
    mode_flag = M.aichat_config.mode_flag,
    mode_arg = M.aichat_config.mode_arg,
    rag = M.aichat_config.rag,
    session = M.aichat_config.session,
  }
  return process_args(args, flags)
end

return M
