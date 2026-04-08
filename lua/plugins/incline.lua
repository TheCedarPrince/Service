return {
  "b0o/incline.nvim",
  lazy = false,
  commit = "0fd2d5a",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "slugbyte/lackluster.nvim",
  },
  config = function()
    local helpers = require("incline.helpers")
    local devicons = require("nvim-web-devicons")
    local lackluster = require("lackluster")

    require("incline").setup({
      debounce_threshold = {
        falling = 50,
        rising = 10
      },
      hide = {
        cursorline = false,
        focused_win = false,
        only_win = false
      },
      highlight = {
        groups = {
          InclineNormal = {
            default = true,
            group = "NormalFloat"
          },
          InclineNormalNC = {
            default = true,
            group = "NormalFloat"
          }
        }
      },
      ignore = {
        buftypes = "special",
        filetypes = {},
        floating_wins = true,
        unlisted_buffers = true,
        wintypes = "special"
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == "" then
          filename = "[No Name]"
        end
        local ft_icon = devicons.get_icon(filename)
        local modified = vim.bo[props.buf].modified
	local modified_icon = {}
        if vim.api.nvim_get_option_value('modified', { buf = props.buf, }) then
          modified_icon = vim.tbl_extend('force', { '●' }, {guifg = lackluster.color.black, guibg=lackluster.color.gray8})
        end
        return {
	  ft_icon and { "" } or "",
	  { modified_icon },
	  ft_icon and { " ", ft_icon, " ", guifg = lackluster.color.black, guibg=lackluster.color.gray8 } or "",
	  { filename, gui = modified and "bold,italic" or "bold", guifg = lackluster.color.black, guibg=lackluster.color.gray8},
	  ft_icon and { "" } or "",
        }
      end,
      window = {
        margin = {
          horizontal = 0,
          vertical = 2
        },
        options = {
          signcolumn = "no",
          wrap = true
        },
        padding = 0,
        placement = {
          horizontal = "right",
          vertical = "top"
        },
        width = "fit",
        winhighlight = {
          active = {
            EndOfBuffer = "None",
            Normal = "InclineNormal",
            Search = "None"
          },
          inactive = {
            EndOfBuffer = "None",
            Normal = "InclineNormalNC",
            Search = "None"
          }
        },
        zindex = 50
      }
    })
  end
}
