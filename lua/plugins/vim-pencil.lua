return {
  "preservim/vim-pencil",
  lazy = false,
  commit = "6d70438a8886eaf933c38a7a43a61adb0a7815ed",
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
