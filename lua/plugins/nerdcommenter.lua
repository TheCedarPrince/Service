return {
	"preservim/nerdcommenter",
  commit = "a462bbda1e26f44fb3d3eb9d9d1c6a07aa98e665",
	lazy = false,
  keys = {
      { "<Space><Space>", "<Plug>NERDCommenterSexy", mode = { "n", "v" }, { noremap = false } },
      { "<Space>u", "<Plug>NERDCommenterToggle", mode = { "n", "v" }, { noremap = false } },
    },
  config = function()
    vim.g.NERDCreateDefaultMappings = 0
    vim.g.NERDSpaceDelims = 1
    vim.g.NERDCommentEmptyLines = 1
    vim.g.NERDTrimTrailingWhitespace = 1
  end
}
