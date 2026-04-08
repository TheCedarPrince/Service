return {
  "junegunn/goyo.vim",
  lazy = false,
  commit = "9c72fdf",
  config = function()
    vim.g.goyo_width = "85%"
    vim.g.goyo_height = "90%"

    -- Expose as a global so the vimscript autocommand can call it
    _G.apply_latex_conceal = function()
      vim.fn.matchadd("Conceal", [[\\\(begin\|end\){[^}]*}]], 10, -1, { conceal = "" })
    end

    vim.cmd [[
      function! s:goyo_enter()
        set noshowmode
	lua require('lualine').hide()
	lua require('incline').setup({hide = {only_win = true}})
        set scl=no
        set conceallevel=2
        set concealcursor=nc
        lua if _G.apply_tex_conceal and vim.bo.filetype == "tex" then _G.apply_tex_conceal() end
      endfunction

      function! s:goyo_leave()
        set showmode
        set conceallevel=2
        set concealcursor=nc
	lua require('lualine').hide({unhide=true})
	lua require('incline').setup({hide = {only_win = false}})
	hi lualine_c_normal guibg=#101010 ctermbg=NONE
	hi lualine_x_normal guibg=#101010 ctermbg=NONE
	hi lualine_c_visual guibg=#101010 ctermbg=NONE
	hi lualine_x_visual guibg=#101010 ctermbg=NONE
	hi lualine_c_command guibg=#101010 ctermbg=NONE
	hi lualine_x_command guibg=#101010 ctermbg=NONE
	hi lualine_c_insert guibg=#101010 ctermbg=NONE
	hi lualine_x_insert guibg=#101010 ctermbg=NONE
      endfunction

      augroup GoyoCallbacks
        autocmd!
        autocmd User GoyoEnter nested call <SID>goyo_enter()
        autocmd User GoyoLeave nested call <SID>goyo_leave()
      augroup END
    ]]
  end,
}
