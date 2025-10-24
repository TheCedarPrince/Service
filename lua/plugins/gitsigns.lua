return {
  "lewis6991/gitsigns.nvim",
  version = "v1.0.2",
  lazy = false,
  config = function()
  require('gitsigns').setup {
  signs = {
    add          = { text = '++' },
    change       = { text = '~~' },
    delete       = { text = '--' },
    topdelete    = { text = '--' },
    changedelete = { text = '--' },
    untracked    = { text = '++' },
  },
  signcolumn = false,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  sign_priority = 6,
  update_debounce = 100,
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
}
  end
}
