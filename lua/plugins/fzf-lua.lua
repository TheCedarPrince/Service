-- ~/.config/nvim/lua/plugins/fzf-lua.lua
-- (or wherever you load plugins — adjust to your plugin manager)

return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require("fzf-lua")
    local actions = require("fzf-lua.actions")

    fzf.setup({
      -- ── Global layout ────────────────────────────────────────────────────
      winopts = {
        height  = 0.92,
        width   = 0.92,
        row     = 0.5,        -- vertically centered
        col     = 0.5,        -- horizontally centered
        border  = "rounded",
        preview = {
          layout      = "horizontal",  -- file list left, preview right
          horizontal  = "right:70%",  -- preview takes 70% of the window
          border      = "border",
          scrollbar   = false,        -- less noise
          title       = true,
          title_pos   = "center",
          winopts = {
            number         = false,   -- no line numbers in preview
            relativenumber = false,
            cursorline     = true,
            signcolumn     = "no",
          },
        },
        -- fzf prompt sits at the bottom of the floating window
        on_create = function()
          vim.keymap.set("t", "<C-j>", "<Down>",  { silent = true, buffer = true })
          vim.keymap.set("t", "<C-k>", "<Up>",    { silent = true, buffer = true })
        end,
      },

      -- ── fzf engine options ───────────────────────────────────────────────
      fzf_opts = {
        ["--layout"] = "reverse",   -- query bar at the bottom
        ["--info"]   = "hidden",    -- hide "N/M" counter — less noise
        ["--padding"] = "0,1",
      },

      -- ── Minimal, clean prompt ────────────────────────────────────────────
      fzf_colors = true,            -- inherit Neovim highlight groups

      -- ── Key bindings (open in split / tab / current buffer) ──────────────
      actions = {
        files = {
          -- default: open in current buffer
          ["enter"]  = actions.file_edit_or_qf,
          -- horizontal split
          ["ctrl-s"] = actions.file_split,
          -- vertical split
          ["ctrl-v"] = actions.file_vsplit,
          -- new tab
          ["ctrl-t"] = actions.file_tabedit,
          -- send matches to quickfix
          ["ctrl-q"] = actions.file_sel_to_qf,
        },
        buffers = {
          ["enter"]  = actions.buf_edit,
          ["ctrl-s"] = actions.buf_split,
          ["ctrl-v"] = actions.buf_vsplit,
          ["ctrl-t"] = actions.buf_tabedit,
        },
      },

      -- Use the builtin previewer so it can show the full filepath as title
      previewers = {
        builtin = {
          title_fnamemodify = function(s) return vim.fn.fnamemodify(s, ":~") end,
        },
      },

      -- ── Per-picker tweaks ────────────────────────────────────────────────
      files = {
        prompt       = "  ",
        cwd_prompt   = false,        -- don't show cwd in the query bar
        formatter    = "path.filename_first",  -- filename prominent, dir dimmed
        git_icons    = true,
        file_icons  = true,
        color_icons = true,
        -- Respect .gitignore; add fd for speed if available
        find_opts   = [[-type f -not -path '*/.git/*']],
        fd_opts     = [[--type f --hidden --follow --exclude .git]],
      },

      grep = {
        prompt       = "  ",
        formatter    = "path.filename_first",
        git_icons    = false,       -- quieter in grep results
        file_icons   = true,
        color_icons  = true,
        rg_opts      = table.concat({
          "--hidden",
          "--follow",
          "--smart-case",
          "--column",
          "--line-number",
          "--no-heading",
          "--color=always",
          "-g '!.git'",
        }, " "),
      },

      buffers = {
        prompt      = "  ",
        file_icons  = true,
        color_icons = true,
        sort_lastused = true,       -- MRU order
        show_unloaded = true,
      },

      lsp = {
        prompt_postfix = "  ❯ ",
        jump_to_single_result = true,   -- skip picker when only one result
        ignore_current_line   = true,
        includeDeclaration    = false,
      },

      -- ── Diagnostics ──────────────────────────────────────────────────────
      diagnostics = {
        prompt      = "  ",
        file_icons  = true,
        color_icons = true,
        severity_limit = vim.diagnostic.severity.HINT,
      },
    })

    -- ── Keymaps ─────────────────────────────────────────────────────────────
    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
    end

    -- Files & search
    map("<leader>ff", fzf.files,           "Find files")
    map("<leader>fr", fzf.oldfiles,        "Recent files")
    map("<leader>fb", fzf.buffers,         "Buffers")
    map("<leader>fg", fzf.live_grep,       "Live grep")
    map("<leader>fw", fzf.grep_cword,      "Grep word under cursor")
    map("<leader>fW", fzf.grep_cWORD,      "Grep WORD under cursor")
    map("<leader>f/", fzf.blines,          "Search current buffer")

    -- Git
    map("<leader>gc", fzf.git_commits,     "Git commits (repo)")
    map("<leader>gC", fzf.git_bcommits,    "Git commits (buffer)")
    map("<leader>gb", fzf.git_branches,    "Git branches")
    map("<leader>gs", fzf.git_status,      "Git status")

    -- LSP
    map("<leader>lr", fzf.lsp_references,          "LSP references")
    map("<leader>ld", fzf.lsp_definitions,          "LSP definitions")
    map("<leader>li", fzf.lsp_implementations,      "LSP implementations")
    map("<leader>ls", fzf.lsp_document_symbols,     "Document symbols")
    map("<leader>lS", fzf.lsp_workspace_symbols,    "Workspace symbols")
    map("<leader>la", fzf.lsp_code_actions,         "Code actions")
    map("<leader>lx", fzf.diagnostics_document,     "Document diagnostics")
    map("<leader>lX", fzf.diagnostics_workspace,    "Workspace diagnostics")

    -- Misc
    map("<leader>fh", fzf.help_tags,       "Help tags")
    map("<leader>fk", fzf.keymaps,         "Keymaps")
    map("<leader>fc", fzf.commands,        "Commands")
    map("<leader>fm", fzf.marks,           "Marks")
    map("<leader>fj", fzf.jumps,           "Jump list")
    map("<leader>f:", fzf.command_history, "Command history")
  end,
}
