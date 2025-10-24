return {
	"vim-ctrlspace/vim-ctrlspace",
	lazy = false,
  cond = function() return not vim.o.diff end,
  init = function()
      vim.g.CtrlSpaceSetDefaultMapping=true
      vim.g.CtrlSpaceUseTabline=true
      vim.g.CtrlSpaceDefaultMappingKey='<M-Space> '
      -- vim.g.CtrlSpaceProjectRootMarkers = {".git", ".hg", ".svn", ".bzr", ".envrc", "_darcs", "CVS"}
  end,
}
