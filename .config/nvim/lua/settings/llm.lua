local M = {}
local api = vim.api
local fn = vim.fn

local api_url = "https://api.straico.com/v1/prompt/completion"
local model_name = "anthropic/claude-3.5-sonnet"

-- local function debug(myTable)
--     if type(myTable) == "table" then
--         for key, value in pairs(myTable) do
--             print(key, value)
--         end
--     else
--         print(myTable)
--     end
-- end

local function get_api_key()
    local api_key = os.getenv("STRAICO_API_KEY")
    if not api_key then
        error("STRAICO_API_KEY environment variable is not set")
    end
    return api_key
end

local function send_request(context, request)
    local body = fn.json_encode({
        models = {model_name},
        message = string.format("Request: %s\nContext: ```%s```\nAnswer the request with the changed code as a single block only, don't add any text before or after", context, request)
    })

    local response = fn.system({
        "curl", "-s", "-X", "POST",
        "-H", "Authorization: Bearer " .. get_api_key(),
        "-H", "Content-Type: application/json",
        "-d", body,
        api_url
    })

    return fn.json_decode(response)
end

function M.edit_code(request)
    local context
    local start_line = 0
    local end_line = -1

    if fn.mode() == "V" then
        start_line, end_line = fn.getpos("'<")[2] ,fn.getpos("'>")[2]
        context = table.concat(api.nvim_buf_get_lines(0, start_line, end_line, false), "")
    else
        context = table.concat(api.nvim_buf_get_lines(0, 0, -1, true), "")
    end

    local response = send_request(context, request)
    if not response then
        vim.notify("Error sending request to API", vim.log.levels.ERROR)
        return
    end

    local completion = response.data.completions[model_name].completion
    local code = completion.choices[1].message.content
    if not code then
        vim.notify("Could not parse response from API", vim.log.levels.ERROR)
        return
    end

    api.nvim_buf_set_lines(0, start_line, end_line, false, vim.split(code, "\n"))
end

api.nvim_create_user_command("LLMCodeChange", function(opts)
    M.edit_code(opts.args)
end, {nargs = 1})
