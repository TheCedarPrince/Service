-- ~/.config/nvim/lua/plugins/diffview.lua
--
-- Single-tabpage diff and file history interface via diffview.nvim.
--
-- ── Global keybinds (<leader>gd) ─────────────────────────────────────────
--   <leader>gdo  — open diffview (index vs working tree)
--   <leader>gdO  — open diffview for a specific git rev (prompts for input)
--   <leader>gdc  — close diffview
--   <leader>gdh  — file history (whole repo)
--   <leader>gdH  — file history (current file only)
--   <leader>gdr  — refresh file list
--
-- ── Inside a diffview — navigation ───────────────────────────────────────
--   <tab>/<s-tab> — next / prev changed file
--   [F / ]F       — first / last file
--   [c / ]c       — prev / next hunk  (vim built-in diff-mode)
--   g<C-x>        — cycle diff layout (horizontal ↔ vertical ↔ …)
--   <leader>e     — focus file panel
--   <leader>b     — toggle file panel
--   gf            — open file in previous tabpage
--   <C-w><C-f>    — open file in new split
--   <C-w>gf       — open file in new tab
--   g?            — open diffview help panel
--
-- ── File panel actions ────────────────────────────────────────────────────
--   j / k         — navigate entries
--   <cr> / o / l  — open diff for entry
--   s / -         — stage / unstage entry
--   S             — stage all
--   U             — unstage all
--   X             — restore file to left-side state
--   i             — toggle list / tree view
--   f             — flatten empty subdirectories
--   R             — refresh
--   L             — open commit log panel
--
-- ── Merge tool (conflict resolution) ─────────────────────────────────────
--   [x / ]x         — prev / next conflict marker
--   <leader>co / cO — choose OURS  (hunk / whole file)
--   <leader>ct / cT — choose THEIRS (hunk / whole file)
--   <leader>cb / cB — choose BASE  (hunk / whole file)
--   <leader>ca / cA — choose ALL   (hunk / whole file)
--   dx / dX         — delete conflict region (hunk / whole file)
--   2do / 3do       — obtain hunk from OURS / THEIRS  (diff3 layout)
--
-- ── File history panel ────────────────────────────────────────────────────
--   <C-A-d>       — open entry in a new diffview
--   y             — copy commit hash under cursor
--   L             — show full commit details

return {
  {
    "sindrets/diffview.nvim",
    commit = "4516612",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewFileHistory",
      "DiffviewRefresh",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
    },
    keys = {
      { "<leader>gdo", "<Cmd>DiffviewOpen<CR>",                        desc = "Open (index)" },
      { "<leader>gdO", function()
          local rev = vim.fn.input("Git rev: ")
          if rev ~= "" then vim.cmd("DiffviewOpen " .. rev) end
        end,                                                            desc = "Open rev…" },
      { "<leader>gdc", "<Cmd>DiffviewClose<CR>",                       desc = "Close" },
      { "<leader>gdh", "<Cmd>DiffviewFileHistory<CR>",                 desc = "File history (repo)" },
      { "<leader>gdH", "<Cmd>DiffviewFileHistory %<CR>",               desc = "File history (this file)" },
      { "<leader>gdr", "<Cmd>DiffviewRefresh<CR>",                     desc = "Refresh" },
    },
    config = function()
      local actions = require("diffview.actions")

      -- ── Register in-view which-key hints when diffview opens ─────────
      -- These are buffer-local bindings that diffview sets itself; we just
      -- surface them in which-key so they appear when you press a prefix
      -- inside a diffview tab. buffer=0 keeps them scoped to the current
      -- buffer and prevents them leaking into the rest of your config.
      local function register_diffview_hints()
        local ok, wk = pcall(require, "which-key")
        if not ok then return end

        wk.add({
          -- ── Navigation ──────────────────────────────────────────────
          { "<tab>",      desc = "Next file",                 mode = "n" },
          { "<s-tab>",    desc = "Prev file",                 mode = "n" },
          { "]F",         desc = "Last file",                 mode = "n" },
          { "[F",         desc = "First file",                mode = "n" },
          { "g<C-x>",     desc = "Cycle layout",              mode = "n" },
          { "gf",         desc = "Open file (prev tabpage)",  mode = "n" },
          { "g?",         desc = "Diffview help",             mode = "n" },

          -- ── Staging workflow (file panel) ────────────────────────────
          { "s",          desc = "Stage / unstage",           mode = "n" },
          { "S",          desc = "Stage all",                 mode = "n" },
          { "U",          desc = "Unstage all",               mode = "n" },
          { "X",          desc = "Restore (left side)",       mode = "n" },
          { "i",          desc = "Toggle list / tree",        mode = "n" },
          { "R",          desc = "Refresh file list",         mode = "n" },
          { "L",          desc = "Commit log / details",      mode = "n" },

          -- ── Conflict resolution group ────────────────────────────────
          { "<leader>c",  group = "conflicts",                mode = "n" },
          { "<leader>co", desc = "OURS (hunk)",               mode = "n" },
          { "<leader>cO", desc = "OURS (file)",               mode = "n" },
          { "<leader>ct", desc = "THEIRS (hunk)",             mode = "n" },
          { "<leader>cT", desc = "THEIRS (file)",             mode = "n" },
          { "<leader>cb", desc = "BASE (hunk)",               mode = "n" },
          { "<leader>cB", desc = "BASE (file)",               mode = "n" },
          { "<leader>ca", desc = "ALL (hunk)",                mode = "n" },
          { "<leader>cA", desc = "ALL (file)",                mode = "n" },
          { "dx",         desc = "Delete conflict (hunk)",    mode = "n" },
          { "dX",         desc = "Delete conflict (file)",    mode = "n" },
          { "[x",         desc = "Prev conflict",             mode = "n" },
          { "]x",         desc = "Next conflict",             mode = "n" },

          -- ── File history panel ───────────────────────────────────────
          { "y",          desc = "Copy commit hash",          mode = "n" },
        }, { buffer = 0 })
      end

      require("diffview").setup({
        diff_binaries    = false,
        enhanced_diff_hl = true,
        use_icons        = true,
        show_help_hints  = true,
        watch_index      = true,

        icons = {
          folder_closed = "",
          folder_open   = "",
        },
        signs = {
          fold_closed = "",
          fold_open   = "",
          done        = "✓",
        },

        view = {
          default = {
            layout              = "diff2_horizontal",
            disable_diagnostics = true,
            winbar_info         = false,
          },
          merge_tool = {
            layout              = "diff3_horizontal",
            disable_diagnostics = true,
            winbar_info         = true,   -- shows OURS / BASE / THEIRS labels
          },
          file_history = {
            layout              = "diff2_horizontal",
            disable_diagnostics = true,
            winbar_info         = false,
          },
        },

        file_panel = {
          listing_style = "tree",
          tree_options  = {
            flatten_dirs    = true,
            folder_statuses = "only_folded",
          },
          win_config = {
            position = "left",
            width    = 35,
            win_opts = {},
          },
        },

        file_history_panel = {
          log_options = {
            git = {
              single_file = { diff_merges = "combined" },
              multi_file  = { diff_merges = "first-parent" },
            },
          },
          win_config = {
            position = "bottom",
            height   = 16,
            win_opts = {},
          },
        },

        hooks = {
          -- Clean up local options and register hints in every diff buffer
          diff_buf_read = function(bufnr)
            vim.opt_local.wrap        = false
            vim.opt_local.list        = false
            vim.opt_local.colorcolumn = {}
            register_diffview_hints()
          end,
          -- Also fires for the file panel and history panel buffers
          view_opened = function(view)
            register_diffview_hints()
          end,
        },

        keymaps = {
          disable_defaults   = false,
          view               = {},
          file_panel         = {},
          file_history_panel = {},
        },
      })
    end,
  },

  -- ── which-key: global <leader>gd group ────────────────────────────────
  -- The <leader>c conflict group is registered buffer-locally on view_opened,
  -- so it won't appear in which-key outside of a diffview tab.
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>gd", group = "diffview" },
      },
    },
  },
}
