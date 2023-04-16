return {
	"anuvyklack/pretty-fold.nvim",
	lazy = false,
	config = function()
	require('pretty-fold').setup{
   		keep_indentation = false,
   		fill_char = '━',
		sections = {
      			left = {
			'━ ', function() return string.rep('*', vim.v.foldlevel) end, ' ━┫', 'content', '┣'
      			},
      			right = {
         			'┫ ', 'percentage', ' ┣━━',
      			}
   		}
	}
	end
}


