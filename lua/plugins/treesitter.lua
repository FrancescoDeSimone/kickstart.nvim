return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  dependencies = { 'OXY2DEV/markview.nvim', 'nvim-treesitter/nvim-treesitter-textobjects' },
  priority = 50,
  build = ':TSUpdate',
  -- main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  --
  -- Nvim 0.12: Builtin incremental selection via treesitter is now available:
  --   an (visual mode) = expand to parent node
  --   in (visual mode) = shrink to child node
  --   [n / ]n (visual mode) = previous/next sibling node
  -- No plugin config needed — these work out of the box with treesitter parsers.
  opts = {
    ensure_installed = {
      'bash', 'c', 'diff', 'html', 'lua', 'luadoc',
      'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'regex',
      'rust', 'cpp', 'zig',
      'go', 'gomod', 'gosum',
      'typescript', 'javascript', 'tsx', 'css',
      'python',
      'nix', 'terraform', 'hcl',
      'json', 'yaml', 'toml',
    },
    -- incremental_selection = {
    --   enable = true,
    --   keymaps = {
    --     init_selection = '<C-space>',
    --     node_incremental = '<C-space>',
    --     scope_incremental = false,
    --     node_decremental = '<bs>',
    --   },
    -- },
    textobjects = {
      move = {
        enable = true,
        goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer', [']a'] = '@parameter.inner' },
        goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer', [']A'] = '@parameter.inner' },
        goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer', ['[a'] = '@parameter.inner' },
        goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer', ['[A'] = '@parameter.inner' },
      },
    },
    auto_install = true,
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
      disable = function(_, buf)
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size and stats.size > 200 * 1024 then
          return true
        end
        local line_count = vim.api.nvim_buf_line_count(buf)
        if line_count > 5000 then
          return true
        end
        return false
      end,
    },
    indent = {
      enable = true,
      disable = function(lang, buf)
        if lang == 'ruby' then
          return true
        end
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size and stats.size > 200 * 1024 then
          return true
        end
        local line_count = vim.api.nvim_buf_line_count(buf)
        if line_count > 5000 then
          return true
        end
        return false
      end,
    },
  },
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
