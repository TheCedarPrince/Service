return {
	"vim-ctrlspace/vim-ctrlspace",
	lazy = false,
  commit = "c8fdf9b",
  cond = function() return not vim.o.diff end,
  init = function()
      vim.g.CtrlSpaceSetDefaultMapping=true
      vim.g.CtrlSpaceUseTabline=true
      vim.g.CtrlSpaceDefaultMappingKey='<M-Space> '
      --[[
         [ vim.g.CtrlSpaceWorkspaceFile = '~/.config/nvim/cs_workspaces'
         ]]
      vim.g.CtrlSpaceProjectRootMarkers = ''
  end,
}
