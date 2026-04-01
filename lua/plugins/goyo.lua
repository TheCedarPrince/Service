return {
  "junegunn/goyo.vim",
  lazy = false,
  commit = "fa0263d",
  config = function()
    vim.g.goyo_width = "85%"
    vim.g.goyo_height = "90%"

    vim.cmd [[
      function! s:goyo_enter()
        set noshowmode
        set scl=no
      endfunction

      function! s:goyo_leave()
        set showmode
        lua require('incline').setup{}
      endfunction

      augroup GoyoCallbacks
        autocmd!
        autocmd User GoyoEnter nested call <SID>goyo_enter()
        autocmd User GoyoLeave nested call <SID>goyo_leave()
      augroup END
    ]]
  end,
}
