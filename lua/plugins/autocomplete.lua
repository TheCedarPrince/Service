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
--   <Tab>/<S-Tab>  — expand snippet or jump between placeholders

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
        paths = { "~/.config/nvim/lua/core/snippets" },
      })
    end,
  },

  -- ── Completion engine ─────────────────────────────────────────────────
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",         -- snippet engine (defined above)
      "hrsh7th/cmp-nvim-lsp",     -- LSP completion source
      "saadparwaiz1/cmp_luasnip", -- bridge: LuaSnip → nvim-cmp
      "hrsh7th/cmp-buffer",       -- buffer word source
      "hrsh7th/cmp-path",         -- filesystem path source
    },
    config = function()
      local cmp     = require("cmp")
      local luasnip = require("luasnip")

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
          ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
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
}
