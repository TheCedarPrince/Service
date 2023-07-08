return {
    "phaazon/hop.nvim",
    lazy = false,
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

-- HopChar1
vim.api.nvim_set_keymap('n', '<C-h>c', "<cmd>lua require'hop'.hint_char1()<cr>", {})

-- HopPattern
vim.api.nvim_set_keymap('n', '<C-h>p', "<cmd>lua require'hop'.hint_patterns()<cr>", {})

vim.api.nvim_command('highlight HopNextKey guifg=none guibg=none gui=none ctermfg=none cterm=bold')
vim.api.nvim_command('highlight HopNextKey1 guifg=none guibg=none gui=none ctermfg=none cterm=bold')
vim.api.nvim_command('highlight HopNextKey2 guifg=none guibg=none gui=none ctermfg=none')
vim.api.nvim_command('highlight HopUnmatched guifg=none guibg=none guisp=none ctermfg=none')

    end
  }

