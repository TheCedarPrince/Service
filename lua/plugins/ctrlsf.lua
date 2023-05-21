return {
  "dyng/ctrlsf.vim",
  lazy = false,
  config = function()
    vim.g.ctrlsf_ackprg = 'rg'  -- Use ag as the search program (requires ag to be installed)
    vim.g.ctrlsf_auto_close = 0  -- Automatically close the ctrlsf window when the search is complete
    vim.g.ctrlsf_auto_focus = 0  -- Automatically focus on the ctrlsf window when it opens
    vim.g.ctrlsf_match_window_bottom = 1  -- Position the ctrlsf window at the bottom of the screen
    vim.g.ctrlsf_max_height = 10  -- Set the maximum height of the ctrlsf window to 10 lines
    vim.g.ctrlsf_auto_preview = 1
    vim.g.ctrlsf_case_sensitive = 'no'
    vim.g.ctrlsf_default_root = 'cwd' 
    vim.g.ctrlsf_fold_result = 0
    vim.g.ctrlsf_winsize = '50%'
  end
}

