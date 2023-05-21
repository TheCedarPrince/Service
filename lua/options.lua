vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.showtabline = 2                         -- always show tabs
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.swapfile = true                         -- creates a swapfile
vim.opt.termguicolors = false                   -- set term gui colors (most terminals support this)
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.updatetime = 300                        -- faster completion (4000ms default)
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.cursorline = true                       -- highlight the current line
vim.opt.number = true                           -- set numbered lines
-- vim.opt.signcolumn = "yes:2"                      -- always show the sign column, and fix it to a width of two
vim.opt.sessionoptions = "tabpages,globals"     -- Remember tab names upon session save
vim.opt.autoread = true				-- Check for updates to files on system
vim.cmd.syntax "off"				-- Turns of syntax highlighting
vim.opt.laststatus = 3 				-- Enable Global Status Line
vim.opt.cmdheight = 0

-- Set tabbing to only two spaces
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
