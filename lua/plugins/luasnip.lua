return {
	"L3MON4D3/LuaSnip",
	build = "make install_jsregexp",
	config = function()
		require("luasnip/loaders/from_vscode").lazy_load()
		require("luasnip/loaders/from_snipmate").lazy_load({ paths = {"~/.config/nvim/snippets"} })
	end
}
