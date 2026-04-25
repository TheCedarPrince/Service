-- ~/.config/nvim/lua/plugins/leap.lua
-- leap.nvim — label-based jump motions. Spiritual successor to hop.nvim /
-- easymotion. Keeps the easymotion/hop spirit: fast, two-keystroke jumps
-- to any visible target.
--
-- Hop → Leap translation:
--   hop hint_words()                → s{char1}{char2}{label}   (forward)
--   hop hint_lines_skip_whitespace  → \jl  (leap linewise, see below)
--   hop multi_windows               → \jw  (leap cross-window)
--
-- Key layout (\j = jump group):
--   s          normal/op  — leap forward  (primary, replaces hop hint_words forward)
--   S          normal/op  — leap backward (hop hint_words backward)
--   gs         normal/op  — leap remote action (operate at distance)
--   \jl        normal     — leap to line starts (replaces hop HopLineStart)
--   \jw        normal     — leap cross-window   (replaces hop multi_windows)
--   \jt        normal     — leap treesitter node select
--
-- Visual mode:
--   s          visual     — leap forward  (selection extend)
--   S is LEFT FREE for vim-surround (wrap visual selection)
--
-- Operator-pending:
--   s / S act as inclusive forward/backward leap targets.

return {
  url = "https://codeberg.org/andyg/leap.nvim",
  dependencies = { "tpope/vim-repeat" }, -- makes leap operations repeatable with .
  event = "VeryLazy",

  config = function()
    local leap = require("leap")

    -- ── Core options (mirrors your hop config intent) ──────────────────────
    leap.opts = vim.tbl_extend("force", leap.opts, {
      -- Jump immediately when there is only one target visible —
      -- matches hop's jump_on_sole_occurrence = true
      max_phase_one_targets = nil,

      -- Case-insensitive search matches hop's case_insensitive = true
      -- (leap uses a different mechanism: it matches regardless of case
      -- when the input is lowercase, smartcase-style)
      case_sensitive = false,

      -- Labels: enough characters to cover dense buffers comfortably.
      -- Placed on home row and neighbours for minimal finger travel.
      labels = "sfnjklhodweimbuyvrgtaqpcxz/",
      safe_labels = "sfnjklhodweimbuyvrgtaqpcxz/",

      -- Show labels on targets even in the special windows leap opens
      -- (matches hop's multi_windows spirit for the gs remote action)
      max_highlighted_traversal_targets = 10,

      -- Dismiss with <Esc> — mirrors hop's quit_key = '<ESC>'
      -- (leap handles this natively; no config key needed, documented here
      -- for clarity)
    })

    -- ── Keymaps ────────────────────────────────────────────────────────────
    --
    -- We do NOT call leap.add_default_mappings() because we want precise
    -- control over which modes get which keys, especially around the S
    -- conflict with vim-surround in visual mode.

    -- s — leap forward in normal, visual, operator-pending
    vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)",
      { desc = "Leap forward" })

    -- S — leap backward in normal and operator-pending ONLY.
    -- Visual mode S is intentionally left for vim-surround (wrap selection).
    vim.keymap.set({ "n", "o" }, "S", "<Plug>(leap-backward)",
      { desc = "Leap backward" })

    -- gs — remote action: leap anywhere, operate there, return
    -- e.g. gs{leap}yap yanks the paragraph under the leap target
    vim.keymap.set({ "n", "x", "o" }, "gs", function()
      require("leap.remote").action()
    end, { desc = "Leap remote action" })

    -- ── Extended motions (\j group) ─────────────────────────────────────────

    -- \jl — jump to line start (non-whitespace), all visible lines.
    -- Direct replacement for hop's hint_lines_skip_whitespace().
    -- Uses leap's linewise mode: targets the first non-blank col of each line.
    vim.keymap.set("n", "<leader>jl", function()
      -- Collect all visible line-start positions and leap to them
      local wininfo = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1]
      local top     = wininfo.topline
      local bot     = wininfo.botline
      local targets = {}
      for lnum = top, bot do
        local line = vim.fn.getline(lnum)
        local col  = line:match("^(%s*)"):len() + 1  -- first non-blank col (1-based)
        if col <= #line + 1 then
          table.insert(targets, { pos = { lnum, col } })
        end
      end
      if #targets == 0 then return end
      require("leap").leap({ targets = targets })
    end, { desc = "Leap to line start (all visible lines)" })

    -- \jw — cross-window leap. Replacement for hop's multi_windows = true.
    -- Leaps to any label across all windows on the current tab page.
    vim.keymap.set("n", "<leader>jw", function()
      require("leap").leap({
        target_windows = vim.tbl_filter(function(win)
          return vim.api.nvim_win_get_config(win).focusable
        end, vim.api.nvim_tabpage_list_wins(0)),
      })
    end, { desc = "Leap cross-window (all visible windows)" })

    -- \jt — treesitter node select. Visually select a syntax node by label.
    -- Think of it as "hop to a semantic chunk" — very useful in code.
    vim.keymap.set({ "n", "x", "o" }, "<leader>jt", function()
      require("leap.treesitter").select()
    end, { desc = "Leap treesitter node select" })

    -- \js — leap forward (explicit whichkey-visible alias for s)
    -- Useful for discoverability; functionally identical to pressing s.
    vim.keymap.set("n", "<leader>js", "<Plug>(leap-forward)",
      { desc = "Leap forward (≡ s)" })

    -- \jS — leap backward (explicit whichkey-visible alias for S)
    vim.keymap.set("n", "<leader>jS", "<Plug>(leap-backward)",
      { desc = "Leap backward (≡ S)" })

    -- ── Optional: preview filter ───────────────────────────────────────────
    -- Reduces the "blink" effect on the first keypress by dimming
    -- non-target characters. Mirrors hop's visual style.
    vim.api.nvim_set_hl(0, "LeapBackdrop",    { link = "Comment" })
    vim.api.nvim_set_hl(0, "LeapMatch",       { fg = "#ff9e64", bold = true })
    vim.api.nvim_set_hl(0, "LeapLabelPrimary",{ fg = "#ff9e64", bold = true })
    vim.api.nvim_set_hl(0, "LeapLabelSecondary", { fg = "#9ece6a" })

    -- ── WhichKey group ──────────────────────────────────────────────────────
    local ok, wk = pcall(require, "which-key")
    if ok then
      wk.add({
        { "<leader>j",  group = "Jump (Leap)" },
        { "<leader>jl", desc  = "Leap → line starts" },
        { "<leader>jw", desc  = "Leap → cross-window" },
        { "<leader>jt", desc  = "Leap → treesitter node" },
        { "<leader>js", desc  = "Leap forward (≡ s)" },
        { "<leader>jS", desc  = "Leap backward (≡ S)" },
        -- Document the bare s/S/gs even though they aren't \j-prefixed,
        -- so they show up in the whichkey popup when relevant
        { "s",          desc  = "Leap forward",         mode = { "n", "x", "o" } },
        { "S",          desc  = "Leap backward",        mode = { "n", "o" } },
        { "gs",         desc  = "Leap remote action",   mode = { "n", "x", "o" } },
      })
    end
  end,
}
