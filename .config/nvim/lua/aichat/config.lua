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
  local mode_menu_items = {
    { text = "Set Role", value = "--role" },
    { text = "Set Agent", value = "--agent" },
    { text = "Set Macro", value = "--macro" },
    { text = "Clear Mode Settings", value = "clear" },
  }

  vim.ui.select(mode_menu_items, {
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

    local flag_options = {}
    if choice.value == "--role" then
      flag_options = get_aichat_results("--list-roles")
    elseif choice.value == "--agent" then
      flag_options = get_aichat_results("--list-agents")
    elseif choice.value == "--macro" then
      flag_options = get_aichat_results("--list-macros")
    end

    if #flag_options > 0 then
      vim.ui.select(flag_options, {
        prompt = "Select value for " .. choice.text .. ":",
      }, function(selected_value)
        if selected_value and selected_value ~= "" then
          M.aichat_config.mode_flag = choice.value
          M.aichat_config.mode_arg = selected_value
          vim.notify(string.format("Set %s to '%s'", choice.text, selected_value))
        end
      end)
    else
      vim.ui.input({
        prompt = "Enter value for " .. choice.text .. ":",
      }, function(input)
        if input and input ~= "" then
          M.aichat_config.mode_flag = choice.value
          M.aichat_config.mode_arg = input
          vim.notify(string.format("Set %s to '%s'", choice.text, input))
        end
      end)
    end
  end)
end

function M.show_rag_menu()
  local rag_options = {
    { text = "Set RAG value", value = "set" },
    { text = "Clear RAG value", value = "clear" },
  }

  vim.ui.select(rag_options, {
    prompt = "RAG options:",
    format_item = function(item) return item.text end,
  }, function(choice)
    if not choice then return end

    if choice.value == "clear" then
      M.aichat_config.rag = nil
      vim.notify("RAG value cleared")
      return
    end

    local rag_values = get_aichat_results("--list-rags")
    if #rag_values > 0 then
      vim.ui.select(rag_values, {
        prompt = "Select RAG value:",
      }, function(selected_value)
        if selected_value and selected_value ~= "" then
          M.aichat_config.rag = selected_value
          vim.notify("RAG set to: " .. selected_value)
        end
      end)
    else
      vim.ui.input({
        prompt = "Enter RAG value:",
        default = M.aichat_config.rag or "",
      }, function(input)
        if input and input ~= "" then
          M.aichat_config.rag = input
          vim.notify("RAG set to: " .. input)
        end
      end)
    end
  end)
end

function M.show_session_menu()
  local session_options = {
    { text = "Set Session value", value = "set" },
    { text = "Clear Session value", value = "clear" },
  }

  vim.ui.select(session_options, {
    prompt = "Session options:",
    format_item = function(item) return item.text end,
  }, function(choice)
    if not choice then return end

    if choice.value == "clear" then
      M.aichat_config.session = nil
      vim.notify("Session value cleared")
      return
    end

    local session_values = get_aichat_results("--list-sessions")
    if #session_values > 0 then
      vim.ui.select(session_values, {
        prompt = "Select Session value:",
      }, function(selected_value)
        if selected_value and selected_value ~= "" then
          M.aichat_config.session = selected_value
          vim.notify("Session set to: " .. selected_value)
        end
      end)
    else
      vim.ui.input({
        prompt = "Enter Session value:",
        default = M.aichat_config.session or "",
      }, function(input)
        if input and input ~= "" then
          M.aichat_config.session = input
          vim.notify("Session set to: " .. input)
        end
      end)
    end
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
