vim.g.coq_settings = {
    auto_start = 'shut-up',
    keymap = {eval_snips = '<leader>j'}
}

require("coq")
require("coq_3p") {
  { src = "nvimlua", short_name = "nLUA" },
}
