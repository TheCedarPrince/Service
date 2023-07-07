return {
  "dbeniamine/todo.txt-vim",
  lazy = false,
  config = function()
    vim.g.Todo_txt_prefix_creation_date = 1  -- Prefix new tasks with the creation date
    vim.g.Todo_fold_char = '+'  -- Set the folding character to '+'
    vim.g.TodoTxtForceDoneName = 'done.txt'  -- Set the name of the done.txt file
  end
}

