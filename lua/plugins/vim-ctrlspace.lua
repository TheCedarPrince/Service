return {
	"vim-ctrlspace/vim-ctrlspace",
	lazy = false,
  commit = "f37c04c",
  cond = function() return not vim.o.diff end,
  init = function()
      vim.g.CtrlSpaceSetDefaultMapping=true
      vim.g.CtrlSpaceUseTabline=true
      vim.g.CtrlSpaceDefaultMappingKey='<M-Space> '
  end,
}
