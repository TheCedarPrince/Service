return {
	"dkarter/bullets.vim",
	lazy = false,
	config = function()

            vim.g.bullets_enabled_file_types = {'markdown', 'text', 'pandoc', 'gitcommit', 'scratch'}
            vim.g.bullets_enable_in_empty_buffers = 1 
            vim.g.bullets_delete_last_bullet_if_empty = 1 
            vim.g.bullets_line_spacing = 2 
            vim.g.bullets_pad_right = 0
            vim.g.bullets_auto_indent_after_colon = 1 
            vim.g.bullets_renumber_on_change = 1
	end
}
