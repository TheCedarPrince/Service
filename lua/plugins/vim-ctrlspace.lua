return {
	"vim-ctrlspace/vim-ctrlspace",
	lazy = false,
  commit = "db7b3091580f4a59c1dcebf127cba312114ebab8",
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
