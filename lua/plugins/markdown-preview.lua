return {
	"iamcco/markdown-preview.nvim",
  commit = "a923f5f",
	lazy = false,
	config = function()
vim.g.mkdp_auto_close = 0 -- Auto close current preview window when change from markdown buffer to another buffer
vim.g.mkdp_refresh_slow = 0 -- Refresh preview while editing

vim.g.mkdp_page_title = '${name}' -- Preview page title

vim.g.mkdp_theme = 'light' -- Set default theme (dark or light)
vim.g.mkdp_echo_preview_url = 1
vim.g.mkdp_port = '8080'
vim.g.mkdp_open_to_the_world = 0 -- set to 1 if you need the server accessible from other devices (e.g. on a LAN)
vim.g.mkdp_combine_preview = 1   -- reuse a single preview tab instead of opening a new one each time
vim.g.mkdp_filetypes = { "markdown", "pandoc", "anki", "text", "txt", "qmd" } 
end
}
