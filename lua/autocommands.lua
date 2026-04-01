-- Description: saves and loads views automatically for a file; add because I wanted support for saving folds across sessions and files.
vim.cmd [[
	augroup SaveFoldsWhenWriting
		autocmd!
		autocmd BufWritePost * mkview | filetype detect
	augroup end

	augroup SaveFoldsWhenQuitting
		autocmd!
		autocmd QuitPre * mkview | filetype detect
	augroup end

	augroup LoadFoldOnStartup
		autocmd!
		autocmd BufWinEnter * silent! loadview | filetype detect
	augroup end
]]

-- Description: Automatically update buffers if a change to the file system was detected
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

