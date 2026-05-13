-- ~/.config/nvim/lua/plugins/gitsigns.lua
--
-- Git decorations and hunk operations via gitsigns.nvim.
--
-- Toggle group (<leader>gt):
--   <leader>gts  — signs in sign column
--   <leader>gtn  — number highlight
--   <leader>gtl  — line highlight
--   <leader>gtw  — word diff
--   <leader>gtb  — current line blame
--
-- Hunk navigation:
--   ]h / [h      — next / prev hunk
--
-- Hunk actions (<leader>g):
--   <leader>gs   — stage hunk
--   <leader>gr   — reset hunk
--   <leader>gS   — stage buffer
--   <leader>gR   — reset buffer
--   <leader>gu   — undo stage hunk
--   <leader>gp   — preview hunk inline
--   <leader>gb   — blame current line (full)
--   <leader>gd   — diff against index
--   <leader>gD   — diff against last commit
--
-- Visual mode:
--   <leader>gs   — stage selected hunk
--   <leader>gr   — reset selected hunk

return {
  {
    "lewis6991/gitsigns.nvim",
    version = "v2.1.0",
    lazy = false,
    config = function()
      local gs = require("gitsigns")

      gs.setup({
        signs = {
          add          = { text = "┃" },
          change       = { text = "┃" },
          delete       = { text = "▁" },
          topdelete    = { text = "▔" },
          changedelete = { text = "~" },
          untracked    = { text = "┆" },
        },
        signcolumn      = true,   -- toggle: <leader>gts
        numhl           = false,  -- toggle: <leader>gtn
        linehl          = false,  -- toggle: <leader>gtl
        word_diff       = false,  -- toggle: <leader>gtw
        current_line_blame = false, -- toggle: <leader>gtb
        watch_gitdir    = { follow_files = true },
        sign_priority   = 6,
        update_debounce = 100,
        max_file_length = 40000,

        on_attach = function(bufnr)
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end

          -- ── Hunk navigation ─────────────────────────────────────────────
          map("n", "]h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gs.nav_hunk("next")
            end
          end, "Next hunk")

          map("n", "[h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gs.nav_hunk("prev")
            end
          end, "Prev hunk")

          -- ── Hunk actions ─────────────────────────────────────────────────
          map("n", "<leader>gs", gs.stage_hunk,                          "Stage hunk")
          map("n", "<leader>gr", gs.reset_hunk,                          "Reset hunk")
          map("n", "<leader>gS", gs.stage_buffer,                        "Stage buffer")
          map("n", "<leader>gR", gs.reset_buffer,                        "Reset buffer")
          map("n", "<leader>gu", gs.undo_stage_hunk,                     "Undo stage hunk")
          map("n", "<leader>gp", gs.preview_hunk_inline,                 "Preview hunk")
          map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
          map("n", "<leader>gd", gs.diffthis,                            "Diff index")
          map("n", "<leader>gD", function() gs.diffthis("~") end,        "Diff last commit")

          -- Visual: stage / reset range
          map("v", "<leader>gs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, "Stage hunk (range)")
          map("v", "<leader>gr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, "Reset hunk (range)")

          -- ── Toggles ──────────────────────────────────────────────────────
          map("n", "<leader>gts", gs.toggle_signs,              "Toggle signs")
          map("n", "<leader>gtn", gs.toggle_numhl,              "Toggle number highlight")
          map("n", "<leader>gtl", gs.toggle_linehl,             "Toggle line highlight")
          map("n", "<leader>gtw", gs.toggle_word_diff,          "Toggle word diff")
          map("n", "<leader>gtb", gs.toggle_current_line_blame, "Toggle line blame")
        end,
      })
    end,
  },

  -- ── which-key labels ───────────────────────────────────────────────────
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>g",  group = "git",     mode = { "n", "v" } },
        { "<leader>gt", group = "toggles" },

        -- Hunk navigation
        { "]h", desc = "Next hunk" },
        { "[h", desc = "Prev hunk" },

        -- Hunk actions
        { "<leader>gs", desc = "Stage hunk",       mode = { "n", "v" } },
        { "<leader>gr", desc = "Reset hunk",       mode = { "n", "v" } },
        { "<leader>gS", desc = "Stage buffer" },
        { "<leader>gR", desc = "Reset buffer" },
        { "<leader>gu", desc = "Undo stage hunk" },
        { "<leader>gp", desc = "Preview hunk" },
        { "<leader>gb", desc = "Blame line" },
        { "<leader>gd", desc = "Diff index" },
        { "<leader>gD", desc = "Diff last commit" },

        -- Toggles
        { "<leader>gts", desc = "Toggle signs" },
        { "<leader>gtn", desc = "Toggle number highlight" },
        { "<leader>gtl", desc = "Toggle line highlight" },
        { "<leader>gtw", desc = "Toggle word diff" },
        { "<leader>gtb", desc = "Toggle line blame" },
      },
    },
  },
}
