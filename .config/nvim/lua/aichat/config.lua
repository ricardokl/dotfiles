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


-- Function to run aichat with a flag and return results as a table
-- @param flag string: The flag to pass to aichat (e.g., "--list-models")
-- @return table: Array of lines from the command output, or empty table on error
local function get_aichat_results(flag)
  -- Validate input
  if not flag or flag == "" then
    vim.notify("Invalid flag provided", vim.log.levels.ERROR)
    return {}
  end

  -- Run the command
  local command = "aichat " .. flag
  local output = vim.fn.system(command)

  -- Check for errors
  if vim.v.shell_error ~= 0 then
    vim.notify("Command failed: " .. output, vim.log.levels.ERROR)
    return {}
  end

  -- Split the output by newlines and filter empty lines
  local results = vim.split(output, "\n", { trimempty = true })

  -- Return the results
  return results
end

function M.show_config_menu()
  local main_menu_items = {
    { text = "Mode Settings", value = "mode" },
    { text = "RAG Settings", value = "rag" },
    { text = "Session Settings", value = "session" },
    { text = "Show Current Config", value = "show" },
  }

  vim.ui.select(main_menu_items, {
    prompt = "Select config category:",
    format_item = function(item) return item.text end,
  }, function(choice)
    if not choice then return end
 
    if choice.value == "mode" then
      M.show_mode_menu()
    elseif choice.value == "rag" then
      M.show_rag_menu()
    elseif choice.value == "session" then
      M.show_session_menu()
    elseif choice.value == "show" then
      M.show_current_config()
    end
  end)
end

function M.show_mode_menu()
  local mode_options = {
    { text = "Set Role", value = "--role", list_cmd = "--list-roles" },
    { text = "Set Agent", value = "--agent", list_cmd = "--list-agents" },
    { text = "Set Macro", value = "--macro", list_cmd = "--list-macros" },
    { text = "Clear Mode Settings", value = "clear" },
  }

  vim.ui.select(mode_options, {
    prompt = "Select mode option:",
    format_item = function(item) return item.text end,
  }, function(choice)
    if not choice then return end

    if choice.value == "clear" then
      M.aichat_config.mode_flag = nil
      M.aichat_config.mode_arg = nil
      vim.notify("Mode settings cleared")
      return
    end

    local options = get_aichat_results(choice.list_cmd)
    if #options > 0 then
      vim.ui.select(options, {
        prompt = "Select value for " .. choice.text .. ":",
      }, function(selected_value)
        if selected_value and selected_value ~= "" then
          M.aichat_config.mode_flag = choice.value
          M.aichat_config.mode_arg = selected_value
          vim.notify(string.format("Set %s to '%s'", choice.text, selected_value))
        end
      end)
    else
      vim.notify("No options available for " .. choice.text, vim.log.levels.ERROR)
    end
  end)
end


function M.show_rag_menu()
  handle_config_menu("RAG", "rag", "--list-rags")
end

function M.show_session_menu()
  handle_config_menu("Session", "session", "--list-sessions")
end

function handle_config_menu(name, config_key, list_command)
  local values = get_aichat_results(list_command)
  local options = {}

  for _, value in ipairs(values) do
    table.insert(options, { text = "Set " .. name .. " to: " .. value, value = value })
  end

  table.insert(options, { text = "Clear " .. name .. " value", value = "clear" })

  vim.ui.select(options, {
    prompt = name .. " options:",
    format_item = function(item) return item.text end,
  }, function(choice)
    if not choice then return end

    if choice.value == "clear" then
      M.aichat_config[config_key] = nil
      vim.notify(name .. " value cleared")
      return
    end

    M.aichat_config[config_key] = choice.value
    vim.notify(name .. " set to: " .. choice.value)
  end)
end

function M.show_current_config()
  local config_str = "Current Configuration:\n"

  if M.aichat_config.mode_flag then
    config_str = config_str .. string.format("Mode: %s '%s'\n",
      M.aichat_config.mode_flag, M.aichat_config.mode_arg or "")
  else
    config_str = config_str .. "Mode: Not set\n"
  end


  config_str = config_str .. "RAG: " .. (M.aichat_config.rag or "Not set") .. "\n"
  config_str = config_str .. "Session: " .. (M.aichat_config.session or "Not set")

  vim.notify(config_str, vim.log.levels.INFO)
end


return M
