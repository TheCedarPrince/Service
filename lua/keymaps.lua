vim.cmd [[
	" press <Tab> to expand or jump in a snippet. 
	imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
]]

-- Toggle gitsigns signs
vim.api.nvim_set_keymap('n', '<Leader>g', ':lua require("gitsigns").toggle_signs()<CR>', { noremap = true, silent = true })
