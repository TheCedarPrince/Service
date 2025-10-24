return {
	"preservim/nerdcommenter",
  commit = "02a3b64",
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
