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

-- Description: Goyo mode support for making Goyo mode as minimalas possible. Also brings back incline support as Goyo disables it.
vim.cmd [[
function! s:goyo_enter()
  " Hides mode from showing
  set noshowmode 

  " Hides the sign column
  :set scl=no 

  " ...
endfunction
function! s:goyo_leave()
  " Makes the signcolumn match the background colorscheme
  highlight clear SignColumn

  hi GitSignsAdd guibg=NONE ctermfg=white
  hi GitSignsChange guibg=NONE ctermfg=white
  hi GitSignsDelete guibg=NONE ctermfg=white

  " Brings mode back
  set showmode 

  " Recreate incline functionality
  lua require'incline'.setup{}

  " ...
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
]]

-- Description: Automatically update buffers if a change to the file system was detected
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

