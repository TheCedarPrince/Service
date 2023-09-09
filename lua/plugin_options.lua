-- Disables highlighting of GitSigns
vim.cmd("hi GitSignsAdd guibg=NONE ctermfg=white")
vim.cmd("hi GitSignsChange guibg=NONE ctermfg=white")
vim.cmd("hi GitSignsDelete guibg=NONE ctermfg=white")

vim.api.nvim_set_hl(0, "WhichKey", { fg = "None" })
vim.api.nvim_set_hl(0, "WhichKeyBorder", { fg = "None" })
vim.api.nvim_set_hl(0, "WhichKeyDesc", { fg = "None" })
vim.api.nvim_set_hl(0, "WhichKeyFloat", { fg = "None" })
vim.api.nvim_set_hl(0, "WhichKeyGroup", { fg = "None" })
vim.api.nvim_set_hl(0, "WhichKeySeparator", { fg = "None" })
vim.api.nvim_set_hl(0, "WhichKeyValue", { fg = "None" })
vim.api.nvim_set_hl(0, "Pmenu", { ctermbg = "None" })
