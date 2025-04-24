local M = {}

-- Constants
local AUGMENT_MARKER = "%*Augment%*"
local CODE_FENCE = "^````"

-- Add error constants for better maintainability
local ERROR_MESSAGES = {
  NO_MARKERS = "No *Augment* markers found",
  NO_CODE_BLOCKS = "No complete code blocks found after last *Augment*",
  INVALID_PATH = "Invalid path provided",
}

-- Helper functions with improved error handling and validation
local function remove_file_protocol(path)
  if not path then return nil end
  return path:gsub("^file://", "")
end

local function get_directory_path(path)
  if not path then return nil end
  local dir = vim.fn.fnamemodify(path, ":h")
  return type(dir) == "string" and dir or nil
end

local function get_absolute_path(path)
  if not path then return nil end
  local abs_path = vim.fn.fnamemodify(path, ":p")
  return type(abs_path) == "string" and abs_path or nil
end

local function create_directory_if_needed(path)
  if not path then return false end
  path = remove_file_protocol(path)
  local dir = get_directory_path(path)
  if not dir then
    vim.notify(ERROR_MESSAGES.INVALID_PATH, vim.log.levels.ERROR)
    return false
  end

  if dir ~= "" and vim.fn.isdirectory(dir) == 0 then
    local success = pcall(vim.fn.mkdir, dir, "p")
    return success
  end
  return true
end

local function update_buffer(path, content)
  if not path or not content then
    vim.notify("Invalid path or content", vim.log.levels.ERROR)
    return false
  end

  path = remove_file_protocol(path)
  local abs_path = get_absolute_path(path)
  if not abs_path then
    vim.notify(ERROR_MESSAGES.INVALID_PATH, vim.log.levels.ERROR)
    return false
  end

  local buf = vim.fn.bufnr(abs_path)
  if buf == -1 then
    buf = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_buf_set_name(buf, abs_path)
  end

  if not vim.api.nvim_buf_is_loaded(buf) then
    vim.fn.bufload(buf)
  end

  local lines = vim.split(content, "\n", { plain = true })

  local ok, err = pcall(vim.api.nvim_buf_set_lines, buf, 0, -1, false, lines)
  if not ok then
    vim.notify(string.format("Failed to update buffer %s: %s", path, err), vim.log.levels.ERROR)
    return false
  end

  vim.notify(string.format("Updated buffer: %s", path), vim.log.levels.INFO)
  return true
end

local function parse_code_block(fence)
  if not fence then return nil, nil end
  local path = fence:match("path=([^%s]+)")
  local mode = fence:match('mode="([^"]+)"') or fence:match("mode=([^%s]+)")
  return path, mode
end

local function find_augment_markers(buf_lines)
  local augment_lines = {}
  local in_code_block = false

  for i, line in ipairs(buf_lines) do
    if line:match(CODE_FENCE) then
      in_code_block = not in_code_block
    elseif not in_code_block and line:match(AUGMENT_MARKER) then
      table.insert(augment_lines, i)
    end
  end

  return augment_lines
end

local function extract_code_blocks(lines)
  local blocks = {}
  local in_code_block = false
  local current_block = nil

  for i, line in ipairs(lines) do
    if line:match(CODE_FENCE) then
      if in_code_block then
        if current_block then
          current_block.lines = table.concat(current_block.content, "\n")
          current_block.line_number = i
          table.insert(blocks, current_block)
          current_block = nil
        end
      else
        current_block = {
          fence = line:sub(4),
          content = {},
          line_number = i
        }
      end
      in_code_block = not in_code_block
    elseif in_code_block and current_block then
      table.insert(current_block.content, line)
    end
  end

  return blocks
end

function M.process_augment_blocks()
  local current_buf = vim.api.nvim_get_current_buf()
  local buf_lines = vim.api.nvim_buf_get_lines(current_buf, 0, -1, false)

  local augment_lines = find_augment_markers(buf_lines)
  if #augment_lines == 0 then
    vim.notify(ERROR_MESSAGES.NO_MARKERS, vim.log.levels.WARN)
    return
  end

  local last_augment = augment_lines[#augment_lines]
  local relevant_lines = vim.list_slice(buf_lines, last_augment + 1)

  local blocks = extract_code_blocks(relevant_lines)
  if #blocks == 0 then
    vim.notify(ERROR_MESSAGES.NO_CODE_BLOCKS, vim.log.levels.WARN)
    return
  end

  local processed_count = 0
  local error_count = 0

  for _, block in ipairs(blocks) do
    local path, mode = parse_code_block(block.fence)

    if path and mode == "EDIT" then
      local ok = pcall(function()
        if create_directory_if_needed(path) then
          if update_buffer(path, block.lines) then
            processed_count = processed_count + 1
          else
            error_count = error_count + 1
          end
        else
          error_count = error_count + 1
          vim.notify(string.format("Failed to create directory for %s", path), vim.log.levels.ERROR)
        end
      end)

      if not ok then
        error_count = error_count + 1
      end
    end
  end

  vim.notify(string.format("Processed %d blocks with %d errors", processed_count, error_count),
    error_count > 0 and vim.log.levels.WARN or vim.log.levels.INFO)
end

-- Register commands and keybindings with descriptions
local function setup_commands()
  vim.api.nvim_create_user_command('AugmentApply', M.process_augment_blocks, {
    desc = "Apply Augment code blocks from current buffer"
  })
end

local function setup_keymaps()
  local keymap_opts = { silent = true, noremap = true }

  vim.keymap.set('n', '<leader>ac', M.send_chat_message,
    vim.tbl_extend('force', keymap_opts, { desc = 'Send message to Augment chat' }))

  vim.keymap.set('n', '<leader>at', function() vim.cmd('Augment chat-toggle') end,
    vim.tbl_extend('force', keymap_opts, { desc = 'Toggle Augment chat panel' }))

  vim.keymap.set('n', '<leader>an', function() vim.cmd('Augment chat-new') end,
    vim.tbl_extend('force', keymap_opts, { desc = 'Clear Augment chat' }))

  vim.keymap.set('n', '<leader>aa', M.process_augment_blocks,
    vim.tbl_extend('force', keymap_opts, { desc = 'Apply Augment code blocks' }))
end

-- Initialize module
local function init()
  setup_commands()
  setup_keymaps()
end

init()

return M
