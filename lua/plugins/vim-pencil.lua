return {
	"preservim/vim-pencil",
	lazy = false,
	config = function()
vim.g['pencil#cursorwrap'] = 0
vim.g['pencil#conceallevel'] = 0
vim.g['pencil#concealcursor'] = 'n'
vim.g['pencil#wrapModeDefault'] = 'soft'
vim.cmd [[
        call pencil#init({'wrap': 'soft'})
]]
end 
}
