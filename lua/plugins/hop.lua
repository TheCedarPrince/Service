return {
    "smoka7/hop.nvim",
    lazy = false,
    version = "*",
    config = function()
      require'hop'.setup{
	quit_key = '<ESC>',
	jump_on_sole_occurrence = true,
	case_insensitive = true,
	multi_windows = true
}

-- hop
require'hop'.setup()

-- HopLineStart
vim.api.nvim_set_keymap('n', '<C-h>l', "<cmd>lua require'hop'.hint_lines_skip_whitespace()<cr>", {})

-- HopWord
vim.api.nvim_set_keymap('n', '<C-h>w', "<cmd>lua require'hop'.hint_words()<cr>", {})

    end
  }

