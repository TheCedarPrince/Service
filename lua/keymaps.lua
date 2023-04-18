vim.cmd [[
	" press <Tab> to expand or jump in a snippet. 
	imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
]]
