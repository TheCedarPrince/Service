return {
	"mbbill/undotree",
	lazy = false,
  commit = "6fa6b57cda8459e1e4b2ca34df702f55242f4e4d",
	config = function()
        vim.cmd([[
        if has("persistent_undo")
           let target_path = expand('~/.undodir')
            " create the directory and any parent directories
            " if the location does not exist.
            if !isdirectory(target_path)
                call mkdir(target_path, "p", 0700)
            endif
            let &undodir=target_path
            set undofile
        endif
        ]])
        vim.g.undotree_WindowLayout = 2
        vim.g.undotree_SetFocusWhenToggle = 1
        vim.g.undotree_ShortIndicators = 1
	end
}
