-- ~/.config/nvim/lua/plugins/autocomplete.lua
--
-- Completion engine (nvim-cmp) and snippet engine (LuaSnip).
-- This is editor-global — it serves all LSPs, not just Julia.
--
-- Snippet sources loaded:
--   VSCode-style snippets  — from installed plugins (e.g. friendly-snippets)
--   SnipMate-style         — from ~/.config/nvim/snippets
--   SnipMate-style         — from ~/.config/nvim/lua/core/snippets (Suffice)
--
-- Completion sources (in priority order):
--   nvim_lsp   — completions from any attached LSP
--   luasnip    — snippet expansion
--   buffer     — words visible in open buffers (keyword_length=4 reduces noise)
--   path       — filesystem paths
--
-- Key mappings:
--   <C-n>/<C-p>    — select next/prev item
--   <C-Space>      — force open completion menu
--   <C-e>          — abort and close menu
--   <CR>           — confirm selection (select=false: only explicit picks)
--   <Tab>/<S-Tab>  — SuperTab: cycles cmp menu when open, otherwise context-
--                    aware (snippet jump → SuperTab fallback → literal Tab)

return {

  -- ── Snippet engine ────────────────────────────────────────────────────
  {
    "L3MON4D3/LuaSnip",
    build   = "make install_jsregexp",
    version = "*",
    config  = function()
      local ls = require("luasnip")

      -- VSCode-style snippets (e.g. from friendly-snippets if installed)
      require("luasnip.loaders.from_vscode").lazy_load()

      -- SnipMate-style snippets from your personal snippet directories
      require("luasnip.loaders.from_snipmate").lazy_load({
        paths = { "~/.config/nvim/snippets" },
      })
      -- Suffice configuration snippets
      require("luasnip.loaders.from_snipmate").lazy_load({
        paths = { "~/.config/nvim/lua/core/lua/core/snippets" },
      })
    end,
  },

  -- ── SuperTab ──────────────────────────────────────────────────────────
  {
    "ervandew/supertab",
    init = function()
      -- Completion direction: <Tab> goes top-to-bottom (feels natural with cmp)
      vim.g.SuperTabDefaultCompletionType = "<c-n>"
      -- Close the preview window when completing
      vim.g.SuperTabClosePreviewOnPopupClose = 1
    end,
  },

  -- ── Completion engine ─────────────────────────────────────────────────
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "ervandew/supertab",        -- SuperTab for Tab cycling
    },
    config = function()
      local cmp     = require("cmp")
      local luasnip = require("luasnip")

      -- Helper: check if there are characters before the cursor (for Tab context)
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
          and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"]     = cmp.mapping.select_next_item(),
          ["<C-p>"]     = cmp.mapping.select_prev_item(),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"]     = cmp.mapping.abort(),
          ["<CR>"]      = cmp.mapping.confirm({ select = false }),

          -- Tab: cycle cmp menu → jump snippet placeholder → SuperTab fallback
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              -- Hand off to SuperTab for its context-aware completion
              vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes("<Plug>SuperTabForward", true, true, true),
                "n", false
              )
            end
          end, { "i", "s" }),

          -- S-Tab: cycle cmp menu backwards → jump snippet placeholder backwards
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes("<Plug>SuperTabBackward", true, true, true),
                "n", false
              )
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer",  keyword_length = 4 },
          { name = "path" },
        }),
      })
    end,
  },

  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<Tab>",     desc = "cmp next / snippet jump / SuperTab", mode = { "i", "s" } },
        { "<S-Tab>",   desc = "cmp prev / snippet jump back",       mode = { "i", "s" } },
        { "<C-Space>", desc = "Open completion menu",               mode = "i" },
        { "<C-e>",     desc = "Abort completion",                   mode = "i" },
        { "<C-n>",     desc = "Next completion item",               mode = "i" },
        { "<C-p>",     desc = "Prev completion item",               mode = "i" },
        { "<CR>",      desc = "Confirm completion (explicit)",       mode = "i" },
      },
    },
  },

}
