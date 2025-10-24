-- Always show the statusline
vim.o.laststatus = 2

-- Define the statusline
vim.o.statusline = table.concat({
  "%F",         -- full file path
  "%=",         -- align right
  "%y ",         -- file type
  "%-8(%l,%c%V%)", -- line, column, virtual column
  "%<%P"        -- percentage through file
})
