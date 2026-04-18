return {
  {
    'saghen/blink.compat',
    version = '*',
    lazy = true,
    opts = {},
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'ray-x/cmp-sql',
    },

    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'super-tab',
        ['<CR>'] = { 'accept', 'fallback' },
      },

      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = { documentation = { auto_show = false } },
      signature = { enabled = true },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'sql' },
        providers = {
          sql = {
            name = 'sql',
            module = 'blink.compat.source',
            score_offset = -3,
            opts = {},
            should_show_items = function()
              return vim.tbl_contains(
                { 'sql' },
                vim.o.filetype
              )
            end,
          },
        },
      },
      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = 'prefer_rust' },
    },
    opts_extend = { 'sources.default' },
  },
}
