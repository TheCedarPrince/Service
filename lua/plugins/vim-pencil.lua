return {
  "preservim/vim-pencil",
  lazy = false,
  version = "*",
  init = function()
    vim.g["pencil#wrapModeDefault"] = "soft"
    vim.g["pencil#conceallevel"] = 2   -- tell pencil to use your desired conceallevel
    vim.g["pencil#concealcursor"] = "nc" -- and concealcursor
  end,
  config = function()
    local group = vim.api.nvim_create_augroup("Pencil", { clear = true })
    vim.api.nvim_create_autocmd("BufEnter", {
      group = group,
      pattern = "*",
      callback = function()
        vim.fn["pencil#init"]()
      end,
    })
  end,
}
