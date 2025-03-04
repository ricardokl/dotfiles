local M = {}

function M.extract_content(input_str)
  -- Check if the string starts with "```"
  if input_str:sub(1, 3) == "```" then
    -- Find the position of the next "```" after the first one
    local start_pos = input_str:find("\n", 4)  -- Start searching after the first line
    local end_pos = input_str:find("```", start_pos, true)

    if end_pos then
      -- Extract the content in the code fences
      input_str = input_str:sub(start_pos, end_pos - 1)
    end
  end

  return input_str
end

return M

