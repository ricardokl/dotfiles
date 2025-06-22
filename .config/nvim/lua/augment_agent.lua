local M = {}

local aug_buf = nil
local current_turn_lines = {}
local is_attached = false
local chat_round = 0
local detach_fn = nil -- Store detach function for cleanup
local current_job = nil

-- Configurable settings
local config = {
  defer_timeout = 50, -- ms
  initial_instruction = "Always output full files, never just partial code. Never omit code, even if it is unchanged",
}

-- Find the AugmentChatHistory buffer by name
function M.find_augment_buffer()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) then -- Check validity first
      local name = vim.api.nvim_buf_get_name(buf)
      if name:match("AugmentChatHistory$") then
        return buf
      end
    end
  end
  return nil
end

function M.attach_if_needed()
  if is_attached then
    if aug_buf and vim.api.nvim_buf_is_valid(aug_buf) then
      return true
    else
      is_attached = false
      if detach_fn then detach_fn() end
    end
  end

  local buf = M.find_augment_buffer()
  if not buf then
    is_attached = false
    return false
  end

  -- Clean up previous attachment if exists
  if detach_fn then
    detach_fn()
    detach_fn = nil
  end

  aug_buf = buf
  current_turn_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

  detach_fn = vim.api.nvim_buf_attach(buf, false, {
    on_lines = function(_, _, firstline, new_lastline, _)
      if not is_attached then return end
      local new = vim.api.nvim_buf_get_lines(buf, firstline, new_lastline, false)
      for idx, line in ipairs(new) do
        local line_num = firstline + idx - 1
        if line_num <= #current_turn_lines then
          current_turn_lines[line_num] = line
        else
          table.insert(current_turn_lines, line)
        end
      end
    end,
    on_detach = function()
      aug_buf = nil
      is_attached = false
      detach_fn = nil
    end
  })

  is_attached = true
  return true
end

function M.flush_current_turn()
  if not is_attached or not aug_buf or not vim.api.nvim_buf_is_valid(aug_buf) then
    vim.notify("Not attached to valid buffer", vim.log.levels.WARN)
    return
  end

  current_turn_lines = vim.api.nvim_buf_get_lines(aug_buf, 0, -1, false)
  local full_text = table.concat(current_turn_lines, "\n")

  if #full_text == 0 then
    return
  end

  if current_job then
    current_job:kill(15) -- SIGTERM
  end
  current_job = vim.system(...)
end

function M.chat(...)
  local args = { ... }
  local message = table.concat(args, " ")

  -- If this is the first round, prefix with instructions
  if chat_round == 0 and config.initial_instruction then
    message = config.initial_instruction .. " " .. message
  end

  chat_round = chat_round + 1
  current_turn_lines = {}
  is_attached = false

  -- Use shellescape for safer command construction
  local cmd = "Augment chat " .. vim.fn.shellescape(message)
  vim.cmd(cmd)

  vim.defer_fn(function()
    if not is_attached then
      M.attach_if_needed()
    end
  end, config.defer_timeout)
end

function M.clear_chat()
  vim.cmd("Augment chat-new")
  chat_round = 0
  current_turn_lines = {}
  is_attached = false
  M.last_extraction = nil -- Reset extraction
  if detach_fn then
    detach_fn()
    detach_fn = nil
  end
end

-- Cleanup on module unload if needed
function M.cleanup()
  if detach_fn then
    pcall(detach_fn) -- Prevent errors during cleanup
    detach_fn = nil
  end
  if current_job then
    pcall(function() current_job:kill(15) end)
    current_job = nil
  end
end

-- Commands
vim.api.nvim_create_user_command("FlushTurn", function()
  M.flush_current_turn()
end, {})

vim.api.nvim_create_user_command("MyAugmentChat", function(opts)
  if #opts.fargs == 0 then
    local input = vim.fn.input("Augment Chat: ")
    if input and input ~= "" then
      M.chat(input)
    end
  else
    M.chat(unpack(opts.fargs))
  end
end, { nargs = "*" })

vim.api.nvim_create_user_command("MyAugmentChatClear", function()
  M.clear_chat()
end, {})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.config and client.config.root_dir then
      vim.g.augment_workspace_folders = vim.g.augment_workspace_folders or {}
      -- Prevent duplicates
      local exists = false
      for _, dir in ipairs(vim.g.augment_workspace_folders) do
        if dir == client.config.root_dir then
          exists = true
          break
        end
      end
      if not exists then
        table.insert(vim.g.augment_workspace_folders, client.config.root_dir)
      end
    end
  end,
})

return M
