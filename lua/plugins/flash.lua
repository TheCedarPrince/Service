-- ~/.config/nvim/lua/plugins/flash.lua
-- flash.nvim — easymotion-style jump labels.
-- Verbatim README defaults, with s→L and S kept as treesitter (n/x/o).
-- Visual S is NOT remapped here — vim-surround owns it in visual mode.

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  commit = "fcea7ff",
  ---@type Flash.Config
  opts = {},
  keys = {
    { "L",     mode = { "n", "x", "o" }, function() require("flash").jump()              end, desc = "Flash" },
    { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter()        end, desc = "Flash Treesitter" },
    { "r",     mode = "o",               function() require("flash").remote()             end, desc = "Remote Flash" },
    { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" },           function() require("flash").toggle()             end, desc = "Toggle Flash Search" },
  },
}
