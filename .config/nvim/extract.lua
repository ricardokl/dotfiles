local function extract_rust_docs()
  local bufnr = vim.api.nvim_get_current_buf()
  local symbols = vim.lsp.buf_request_sync(bufnr, 'textDocument/documentSymbol', {
    textDocument = vim.lsp.util.make_text_document_params()
  }, 1000)

  local docs = {}

  if symbols and symbols[1] and symbols[1].result then
    local function process_symbols(symbols_list, namespace)
      for _, symbol in ipairs(symbols_list) do
        local kind = symbol.kind
        local name = symbol.name
        local detail = symbol.detail or ""
        local full_name = namespace and (namespace .. "::" .. name) or name
        local documentation = ""

        -- Extract documentation if available
        if symbol.documentation then
          if type(symbol.documentation) == "string" then
            documentation = symbol.documentation
          elseif type(symbol.documentation) == "table" and symbol.documentation.value then
            documentation = symbol.documentation.value
          end
        end

        -- If no documentation is available, try to get it from the hover provider
        if documentation == "" and symbol.range then
          local start_line = symbol.range.start.line
          local start_char = symbol.range.start.character

          local hover_params = {
            textDocument = vim.lsp.util.make_text_document_params(),
            position = { line = start_line, character = start_char }
          }

          local hover_result = vim.lsp.buf_request_sync(bufnr, 'textDocument/hover', hover_params, 1000)
          if hover_result and hover_result[1] and hover_result[1].result and
              hover_result[1].result.contents then
            local contents = hover_result[1].result.contents
            if type(contents) == "string" then
              documentation = contents
            elseif type(contents) == "table" then
              if contents.value then
                documentation = contents.value
              elseif #contents > 0 then
                local doc_parts = {}
                for _, part in ipairs(contents) do
                  if type(part) == "string" then
                    table.insert(doc_parts, part)
                  elseif type(part) == "table" and part.value then
                    table.insert(doc_parts, part.value)
                  end
                end
                documentation = table.concat(doc_parts, "\n\n")
              end
            end
          end
        end

        -- Extract based on symbol kind (function, struct, enum, etc.)
        if kind == 12 then -- Function
          table.insert(docs, {
            type = "function",
            name = full_name,
            signature = detail,
            documentation = documentation,
            range = symbol.range
          })
        elseif kind == 5 then -- Class/Struct
          table.insert(docs, {
            type = "struct",
            name = full_name,
            detail = detail,
            documentation = documentation,
            range = symbol.range
          })
        elseif kind == 10 then -- Enum
          table.insert(docs, {
            type = "enum",
            name = full_name,
            detail = detail,
            documentation = documentation,
            range = symbol.range
          })
        elseif kind == 14 then -- Constant
          table.insert(docs, {
            type = "constant",
            name = full_name,
            detail = detail,
            documentation = documentation,
            range = symbol.range
          })
        end

        -- Process children recursively
        if symbol.children then
          process_symbols(symbol.children, full_name)
        end
      end
    end

    process_symbols(symbols[1].result, nil)
  end

  return docs
end

-- Function to generate markdown documentation
local function generate_markdown_docs()
  local docs = extract_rust_docs()
  local markdown = "# Rust Crate Documentation\n\n"

  -- Group by type
  local functions = {}
  local structs = {}
  local enums = {}
  local constants = {}

  for _, item in ipairs(docs) do
    if item.type == "function" then
      table.insert(functions, item)
    elseif item.type == "struct" then
      table.insert(structs, item)
    elseif item.type == "enum" then
      table.insert(enums, item)
    elseif item.type == "constant" then
      table.insert(constants, item)
    end
  end

  -- Add functions
  if #functions > 0 then
    markdown = markdown .. "## Functions\n\n"
    for _, func in ipairs(functions) do
      markdown = markdown .. "### `" .. func.name .. "`\n\n"
      markdown = markdown .. "```rust\n" .. func.signature .. "\n```\n\n"
      if func.documentation and func.documentation ~= "" then
        markdown = markdown .. func.documentation .. "\n\n"
      end
    end
  end

  -- Add structs
  if #structs > 0 then
    markdown = markdown .. "## Structs\n\n"
    for _, struct in ipairs(structs) do
      markdown = markdown .. "### `" .. struct.name .. "`\n\n"
      if struct.detail and struct.detail ~= "" then
        markdown = markdown .. "```rust\n" .. struct.detail .. "\n```\n\n"
      end
      if struct.documentation and struct.documentation ~= "" then
        markdown = markdown .. struct.documentation .. "\n\n"
      end
    end
  end

  -- Add enums
  if #enums > 0 then
    markdown = markdown .. "## Enums\n\n"
    for _, enum in ipairs(enums) do
      markdown = markdown .. "### `" .. enum.name .. "`\n\n"
      if enum.detail and enum.detail ~= "" then
        markdown = markdown .. "```rust\n" .. enum.detail .. "\n```\n\n"
      end
      if enum.documentation and enum.documentation ~= "" then
        markdown = markdown .. enum.documentation .. "\n\n"
      end
    end
  end

  -- Add constants
  if #constants > 0 then
    markdown = markdown .. "## Constants\n\n"
    for _, constant in ipairs(constants) do
      markdown = markdown .. "### `" .. constant.name .. "`\n\n"
      if constant.detail and constant.detail ~= "" then
        markdown = markdown .. "```rust\n" .. constant.detail .. "\n```\n\n"
      end
      if constant.documentation and constant.documentation ~= "" then
        markdown = markdown .. constant.documentation .. "\n\n"
      end
    end
  end

  -- Write the documentation to a file
  local file_path = '/home/ricardo/projects/rust_docs.md'
  local file = io.open(file_path, "w")
  if file then
    file:write(markdown)
    file:close()
    print("Documentation written to " .. file_path)
  else
    print("Error: Could not open file for writing at " .. file_path)

    -- Create a new buffer with the documentation as fallback
    local new_buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_buf_set_lines(new_buf, 0, -1, false, vim.split(markdown, "\n"))
    vim.api.nvim_command("buffer " .. new_buf)
    vim.api.nvim_command("set filetype=markdown")
  end
end

-- Map to a command
vim.api.nvim_create_user_command("RustDocs", generate_markdown_docs, {})

local function generate_docs_for_namespace()
  local namespace = "nvim_oxi"
  local items = {}
  local processed_count = 0

  -- Try to get symbols from the current buffer instead of workspace
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_active_clients({ bufnr = bufnr })

  if #clients == 0 then
    vim.notify("No active LSP clients found for current buffer")
    return
  end

  local client_id = clients[1].id

  -- Use document symbols instead of workspace symbols
  vim.lsp.buf_request(bufnr, 'textDocument/documentSymbol', {
    textDocument = { uri = vim.uri_from_bufnr(bufnr) }
  }, function(err, symbols, _, _)
    if err or not symbols then
      vim.notify("Error fetching symbols: " .. (err or "No symbols found"))
      return
    end

    if #symbols == 0 then
      vim.notify("No symbols found in current document")

      -- Fallback to manually searching for the namespace in imports
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      local potential_symbols = {}

      for _, line in ipairs(lines) do
        if line:match(namespace) then
          local symbol_name = line:match("(%w+)%s*=%s*" .. namespace .. "%.([%w_]+)")
          if symbol_name then
            table.insert(potential_symbols, { name = symbol_name })
          end
        end
      end

      if #potential_symbols > 0 then
        vim.notify("Found " .. #potential_symbols .. " potential symbols from imports")
        symbols = potential_symbols
      else
        -- Try to get completion items for the namespace
        vim.lsp.buf_request(bufnr, 'textDocument/completion', {
          textDocument = { uri = vim.uri_from_bufnr(bufnr) },
          position = { line = 0, character = 0 },
          context = {
            triggerKind = 1,
            triggerCharacter = "."
          }
        }, function(comp_err, comp_result, _, _)
          if comp_err or not comp_result or #comp_result.items == 0 then
            vim.notify("Could not find any symbols for namespace: " .. namespace)
            return
          end

          vim.notify("Found " .. #comp_result.items .. " completion items")

          -- Process completion items
          for _, item in ipairs(comp_result.items) do
            table.insert(items, {
              name = item.label,
              documentation = item.documentation and
                  (type(item.documentation) == "table" and item.documentation.value or item.documentation) or
                  "No documentation available"
            })
          end

          -- Write to file
          local file = io.open("/home/ricardo/projects/nvim_oxi_api_docs.md", "w")
          file:write("# nvim_oxi Documentation\n\n")

          table.sort(items, function(a, b) return a.name < b.name end)

          for _, item in ipairs(items) do
            file:write("## " .. item.name .. "\n\n")
            file:write(item.documentation .. "\n\n")
          end

          file:close()
          vim.notify("Documentation generated in nvim_oxi_api_docs.md with " .. #items .. " items")
        end)
        return
      end
    end

    vim.notify("Found " .. #symbols .. " symbols to process")

    -- Process each symbol
    for _, symbol in ipairs(symbols) do
      local symbolInfo = symbol.location or symbol
      local position = symbolInfo.range and symbolInfo.range.start or { line = 0, character = 0 }

      -- Request hover information for each symbol
      vim.lsp.buf_request(bufnr, 'textDocument/hover', {
        textDocument = {
          uri = symbolInfo.uri or vim.uri_from_bufnr(bufnr)
        },
        position = position
      }, function(hover_err, hover_result, _, _)
        processed_count = processed_count + 1

        if not hover_err and hover_result and hover_result.contents then
          local content
          if type(hover_result.contents) == "table" then
            if hover_result.contents.value then
              content = hover_result.contents.value
            elseif hover_result.contents.kind and hover_result.contents.language then
              content = hover_result.contents.value or ""
            else
              -- Handle array of contents
              local contents = {}
              for _, c in ipairs(hover_result.contents) do
                if type(c) == "string" then
                  table.insert(contents, c)
                elseif type(c) == "table" and c.value then
                  table.insert(contents, c.value)
                end
              end
              content = table.concat(contents, "\n\n")
            end
          else
            content = hover_result.contents
          end

          if content then
            table.insert(items, {
              name = symbol.name,
              documentation = content
            })
          end
        end

        -- Write to file when all items are processed
        if processed_count == #symbols then
          if #items > 0 then
            local file = io.open("/home/ricardo/projects/nvim_oxi_api_docs.md", "w")
            file:write("# nvim_oxi Documentation\n\n")

            table.sort(items, function(a, b) return a.name < b.name end)

            for _, item in ipairs(items) do
              file:write("## " .. item.name .. "\n\n")
              file:write(item.documentation .. "\n\n")
            end

            file:close()
            vim.notify("Documentation generated in nvim_oxi_api_docs.md with " .. #items .. " items")
          else
            vim.notify("No documentation content was found for any symbols")
          end
        end
      end)
    end
  end)
end


vim.api.nvim_create_user_command("GenDocs", generate_docs_for_namespace, {})
