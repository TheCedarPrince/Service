local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.python3_host_prog = '/home/thecedarprince/Programs/Miniconda3/envs/neovim/bin/python'
require("options")
require("lazy").setup("plugins")
require("autocommands")
require("keymaps")
require("functions")
require("colors")
require("bar")
