return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  commit = "3aab2147e74890957785941f0c1ad87d0a44c15a",
  opts = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 10, -- how many suggestions should be shown in the list?
    },
    presets = {
      operators = true, -- adds help for operators like d, y, ...
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
    win = {
      width = { min = 30, max = 60 },
      height = { min = 4, max = 0.75 },
      padding = { 0, 1 },
      col = 1,
      row = -1,
      border = "rounded",
      title = false,
      -- title_pos = "left",
    },
    layout = {
      width = { min = 30 },
    },
    icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "|", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
    ellipsis = "…",
    }

  }
}
