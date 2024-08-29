local function wrap(tag, content, lang)
  local output = {}
  table.insert(output, "<" .. tag .. ">\n")
  if lang ~= nil then table.insert(output, "```" .. lang .. "\n") end
  table.insert(output, content .. "\n")
  if lang ~= nil then table.insert(output, "```\n") end
  table.insert(output, "</" .. tag .. ">\n")
  return table.concat(output)
end


local function parse_message_straico(code_opts)
  local user_prompt_table = {code_opts.base_prompt, "\n"}
  if code_opts.selected_code_content ~= nil then
    table.insert(user_prompt_table,
      wrap("CODE CONTEXT", code_opts.code_content, code_opts.code_lang))
    table.insert(user_prompt_table,
      wrap("CODE", code_opts.selected_code_content, code_opts.code_lang))
  else
    table.insert(user_prompt_table,
      wrap("CODE", code_opts.code_content, code_opts.code_lang))
  end
  table.insert(user_prompt_table, wrap("QUESTION", code_opts.question))
  local message = wrap("system", code_opts.system_prompt) .. wrap("user", table.concat(user_prompt_table))
  return message
end

require("avante").setup({
  provider = "straico",
  vendors = {
    straico = {
      endpoint = "https://api.straico.com/v1/prompt/completion",
      model = "anthropic/claude-3.5-sonnet",
      timeout = 30000,
      api_key_name = "STRAICO_API_KEY",
      parse_curl_args = function(opts, code_opts)
        return {
          url = opts.endpoint,
          headers = {
            ["Accept"] = "application/json",
            ["Content-Type"] = "application/json",
            ["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
          },
          body = {
            models = {opts.model},
            message = parse_message_straico(code_opts),
          },
        }
      end,
      parse_stream_data = function(data, handler_opts)
        local json = vim.json.decode(data)
        local choice = json.data.completions["anthropic/claude-3.5-sonnet"].choices[1]
        handler_opts.on_complete(choice.message.content)
      end,
    },
    groq = {
      endpoint = "https://api.groq.com/openai/v1/chat/completions",
      model = "llama-3.1-70b-versatile",
      api_key_name = "GROQ_API_KEY",
      parse_curl_args = function(opts, code_opts)
        return {
          url = opts.endpoint,
          headers = {
            ["Accept"] = "application/json",
            ["Content-Type"] = "application/json",
            ["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
          },
          body = {
            model = opts.model,
            messages = require("avante.providers").azure.parse_message(code_opts),
            temperature = 0,
            max_tokens = 4096,
            stream = true,
          },
        }
      end,
      parse_response_data = function(data_stream, event_state, opts)
        require("avante.providers").azure.parse_response(data_stream, event_state, opts)
      end,
    },
  },
  windows = {
    wrap = true,
    width = 30,
    sidebar_header = {
      align = "center",
      rounded = true,
    },
  },
}
)
