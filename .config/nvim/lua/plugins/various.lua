return {
  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },
  {
    "jiangmiao/auto-pairs",
  },
  {
    "numToStr/Navigator.nvim",
    config = function()
      require('Navigator').setup({})
    end
  },
}
