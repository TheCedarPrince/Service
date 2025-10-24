return {
	"vim-voom/VOoM",
	lazy = false,
  commit = "423600d",
	config = function()
vim.g.voom_python_versions = {3} -- Enforces use of Python 3
vim.g.voom_tree_placement = 'bottom' -- Automatically opens the outliner below the current buffer 
vim.g.voom_default_mode = 'pandoc' -- Set the default outliner of the Voom command to pandoc
end
}
