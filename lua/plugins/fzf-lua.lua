-- ~/.config/nvim/lua/plugins/fzf-lua.lua

return {
  "ibhagwan/fzf-lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/which-key.nvim",
  },
  config = function()
    local fzf     = require("fzf-lua")
    local actions = require("fzf-lua.actions")
    local wk      = require("which-key")

    fzf.setup({
      -- ── Global layout ────────────────────────────────────────────────────
      winopts = {
        height  = 0.92,
        width   = 0.92,
        row     = 0.5,
        col     = 0.5,
        border  = "rounded",
        preview = {
          layout      = "horizontal",
          horizontal  = "right:70%",
          border      = "border",
          scrollbar   = false,
          title       = true,
          title_pos   = "center",
          winopts = {
            number         = false,
            relativenumber = false,
            cursorline     = true,
            signcolumn     = "no",
          },
        },
        on_create = function()
          vim.keymap.set("t", "<C-j>", "<Down>", { silent = true, buffer = true })
          vim.keymap.set("t", "<C-k>", "<Up>",   { silent = true, buffer = true })
        end,
      },

      -- ── fzf engine options ───────────────────────────────────────────────
      fzf_opts = {
        ["--layout"]  = "reverse",
        ["--info"]    = "hidden",
        ["--padding"] = "0,1",
      },

      fzf_colors = true,

      -- ── Key bindings ─────────────────────────────────────────────────────
      actions = {
        files = {
          ["enter"]  = actions.file_edit_or_qf,
          ["ctrl-s"] = actions.file_split,
          ["ctrl-v"] = actions.file_vsplit,
          ["ctrl-t"] = actions.file_tabedit,
          ["ctrl-q"] = actions.file_sel_to_qf,
        },
        buffers = {
          ["enter"]  = actions.buf_edit,
          ["ctrl-s"] = actions.buf_split,
          ["ctrl-v"] = actions.buf_vsplit,
          ["ctrl-t"] = actions.buf_tabedit,
        },
      },

      previewers = {
        builtin = {
          title_fnamemodify = function(s) return vim.fn.fnamemodify(s, ":~") end,
        },
      },

      -- ── Per-picker tweaks ────────────────────────────────────────────────
      files = {
        prompt      = "  ",
        cwd_prompt  = false,
        formatter   = "path.filename_first",
        git_icons   = true,
        file_icons  = true,
        color_icons = true,
        find_opts   = [[-type f -not -path '*/.git/*']],
        fd_opts     = [[--type f --hidden --follow --exclude .git]],
      },

      grep = {
        prompt      = "  ",
        formatter   = "path.filename_first",
        git_icons   = false,
        file_icons  = true,
        color_icons = true,
        rg_opts     = table.concat({
          "--hidden", "--follow", "--smart-case",
          "--column", "--line-number", "--no-heading",
          "--color=always", "-g '!.git'",
        }, " "),
      },

      buffers = {
        prompt        = "  ",
        file_icons    = true,
        color_icons   = true,
        sort_lastused = true,
        show_unloaded = true,
      },

      lsp = {
        prompt_postfix        = "  ❯ ",
        jump_to_single_result = true,
        ignore_current_line   = true,
        includeDeclaration    = false,
      },

      diagnostics = {
        prompt         = "  ",
        file_icons     = true,
        color_icons    = true,
        severity_limit = vim.diagnostic.severity.HINT,
      },
    })

    -- ── which-key registrations ──────────────────────────────────────────
    wk.add({
      -- Group labels
      { "<leader>f",  group = "Find" },
      { "<leader>g",  group = "Git" },
      { "<leader>l",  group = "LSP" },

      -- Files & search
      { "<leader>ff", fzf.files,           desc = "Find files" },
      { "<leader>fr", fzf.oldfiles,        desc = "Recent files" },
      { "<leader>fb", fzf.buffers,         desc = "Buffers" },
      { "<leader>fg", fzf.live_grep,       desc = "Live grep" },
      { "<leader>fw", fzf.grep_cword,      desc = "Grep word under cursor" },
      { "<leader>fW", fzf.grep_cWORD,      desc = "Grep WORD under cursor" },
      { "<leader>f/", fzf.blines,          desc = "Search current buffer" },
      { "<leader>fh", fzf.help_tags,       desc = "Help tags" },
      { "<leader>fk", fzf.keymaps,         desc = "Keymaps" },
      { "<leader>fc", fzf.commands,        desc = "Commands" },
      { "<leader>fm", fzf.marks,           desc = "Marks" },
      { "<leader>fj", fzf.jumps,           desc = "Jump list" },
      { "<leader>f:", fzf.command_history, desc = "Command history" },

      -- Git
      { "<leader>gc", fzf.git_commits,     desc = "Commits (repo)" },
      { "<leader>gC", fzf.git_bcommits,    desc = "Commits (buffer)" },
      { "<leader>gb", fzf.git_branches,    desc = "Branches" },
      { "<leader>gs", fzf.git_status,      desc = "Status" },

      -- LSP
      { "<leader>lr", fzf.lsp_references,         desc = "References" },
      { "<leader>ld", fzf.lsp_definitions,         desc = "Definitions" },
      { "<leader>li", fzf.lsp_implementations,     desc = "Implementations" },
      { "<leader>ls", fzf.lsp_document_symbols,    desc = "Document symbols" },
      { "<leader>lS", fzf.lsp_workspace_symbols,   desc = "Workspace symbols" },
      { "<leader>la", fzf.lsp_code_actions,        desc = "Code actions" },
      { "<leader>lx", fzf.diagnostics_document,    desc = "Document diagnostics" },
      { "<leader>lX", fzf.diagnostics_workspace,   desc = "Workspace diagnostics" },
    })
  end,
}
