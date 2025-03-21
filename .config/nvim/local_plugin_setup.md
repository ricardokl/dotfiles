# Method 2: Add a file in your plugins directory (Recommended)

Create a new file in your plugins directory (likely at `~/.config/nvim/lua/plugins/your_plugin.lua`):

```lua
-- ~/.config/nvim/lua/plugins/your_plugin.lua
return {
  {
    dir = "/full/path/to/your/plugin",
    build = "./build.sh",  -- For your Rust plugin
    config = function()
      require("your_plugin").setup({
        -- your configuration options
      })
    end
  }
}
```

This second method is generally preferred as it keeps your plugin configurations organized in separate files.

## Development-Friendly Options

For a local development plugin, you might want these additional options:

```lua
{
  dir = "/full/path/to/your/plugin",
  build = "./build.sh",
  dev = true,           -- Mark as development plugin
  lazy = false,         -- Load at startup for easier testing
  priority = 1000,      -- Load early
  config = function()
    require("your_plugin").setup({
      -- options
    })
  end
}

