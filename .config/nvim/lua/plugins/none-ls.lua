return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      source = {
        -- Install stylua, black and isort via mason
        null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.formatting.black,
        -- null_ls.builtins.formatting.isort,
      }
    })
  end
}
