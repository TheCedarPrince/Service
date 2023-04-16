vim.cmd [[
	augroup remember_folds
		autocmd! 
		autocmd BufWinLeave ?* mkview | filetype detect
		autocmd BufWinLeave ?* silent loadview | filetype detect
	augroup END
]]
