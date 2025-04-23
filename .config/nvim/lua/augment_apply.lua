local M = {}

-- Constants
local AUGMENT_MARKER = "%*Augment%*"
local CODE_FENCE = "^````"

-- Helper functions
local function create_directory_if_needed(path)
  local dir = vim.fn.fnamemodify(path, ":h")
  if dir ~= "" and vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end
end

local function write_file(path, content)
  local file = io.open(path, "w")
  if not file then
    error(string.format("Failed to open file: %s", path))
  end
  file:write(content)
  file:close()
  vim.notify(string.format("Updated: %s", path), vim.log.levels.INFO)
end

local function parse_code_block(fence)
  local path = fence:match("path=([^%s]+)")
  local mode = fence:match("mode=([^%s]+)")
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

  for _, line in ipairs(lines) do
    if line:match(CODE_FENCE) then
      if in_code_block then
        if current_block then
          current_block.lines = table.concat(current_block.content, "\n")
          table.insert(blocks, current_block)
          current_block = nil
        end
      else
        current_block = {
          fence = line:sub(4),
          content = {}
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

  -- Find Augment markers
  local augment_lines = find_augment_markers(buf_lines)
  if #augment_lines == 0 then
    vim.notify("No *Augment* markers found", vim.log.levels.WARN)
    return
  end

  -- Get lines after last Augment marker
  local last_augment = augment_lines[#augment_lines]
  local relevant_lines = vim.list_slice(buf_lines, last_augment + 1)

  -- Process code blocks
  local blocks = extract_code_blocks(relevant_lines)
  if #blocks == 0 then
    vim.notify("No complete code blocks found after last *Augment*", vim.log.levels.WARN)
    return
  end

  -- Process valid blocks
  for _, block in ipairs(blocks) do
    local path, mode = parse_code_block(block.fence)

    if path and mode == "EDIT" then
      local ok, err = pcall(function()
        create_directory_if_needed(path)
        write_file(path, block.lines)
      end)

      if not ok then
        vim.notify(string.format("Error processing %s: %s", path, err), vim.log.levels.ERROR)
      end
    end
  end
end

-- Register command
vim.api.nvim_create_user_command('AugmentApply', M.process_augment_blocks, {})

return M

