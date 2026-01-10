return {
  -- 1. Neogit: The Magit clone (replaces Fugitive)
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'folke/snacks.nvim', -- Used for pickers (branches, logs, etc.)
    },
    config = function()
      local neogit = require 'neogit'
      neogit.setup {
        disable_signs = false,
        disable_hint = true,
        disable_context_highlighting = false,
        -- Enable Snacks integration for pickers
        integrations = {
          diffview = true,
          snacks = true,
          telescope = false,
        },
        commit_editor = {
          kind = 'split',
          show_staged_diff = true,
        },
        popup = {
          kind = 'split',
        },
        signs = {
          section = { '', '' },
          item = { '', '' },
          hunk = { '', '' },
        },
      }

      -- Keymaps: <leader>g is the entry point
      local map = vim.keymap.set
      local opts = { desc = '' }

      -- Main Status Dashboard
      opts.desc = 'Neogit Status'
      map('n', '<leader>gg', neogit.open, opts)

      -- Common Git Actions
      opts.desc = 'Git Commit'
      map('n', '<leader>gc', ':Neogit commit<CR>', opts)
      opts.desc = 'Git Pull'
      map('n', '<leader>gp', ':Neogit pull<CR>', opts)
      opts.desc = 'Git Push'
      map('n', '<leader>gP', ':Neogit push<CR>', opts)

      -- Branch & Log (Uses Snacks Picker via Neogit)
      opts.desc = 'Git Branches'
      map('n', '<leader>gb', ':Neogit branch<CR>', opts)
      opts.desc = 'Git Log'
      map('n', '<leader>gl', ':Neogit log<CR>', opts)
    end,
  },

  -- 2. Gitsigns: Gutter signs and Hunk actions
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gs = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']h', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Next Hunk' })

        map('n', '[h', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Prev Hunk' })

        -- Actions: Standardized to <leader>gh (Git Hunk)
        map('n', '<leader>ghs', gs.stage_hunk, { desc = 'Stage Hunk' })
        map('n', '<leader>ghr', gs.reset_hunk, { desc = 'Reset Hunk' })
        map('v', '<leader>ghs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'Stage Hunk' })
        map('v', '<leader>ghr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'Reset Hunk' })

        map('n', '<leader>ghS', gs.stage_buffer, { desc = 'Stage Buffer' })
        map('n', '<leader>ghu', gs.undo_stage_hunk, { desc = 'Undo Stage Hunk' })
        map('n', '<leader>ghR', gs.reset_buffer, { desc = 'Reset Buffer' })
        map('n', '<leader>ghp', gs.preview_hunk, { desc = 'Preview Hunk' })
        map('n', '<leader>ghb', function()
          gs.blame_line { full = true }
        end, { desc = 'Blame Line' })
        map('n', '<leader>ght', gs.toggle_current_line_blame, { desc = 'Toggle Blame' })
        map('n', '<leader>ghd', gs.diffthis, { desc = 'Diff This' })
      end,
    },
  },

  -- 3. Diffview: Advanced Diffing Interface
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Diffview Open' },
      { '<leader>gD', '<cmd>DiffviewClose<cr>', desc = 'Diffview Close' },
      { '<leader>ghf', '<cmd>DiffviewFileHistory %<cr>', desc = 'File History (Current)' },
      { '<leader>ghF', '<cmd>DiffviewFileHistory<cr>', desc = 'File History (All)' },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        merge_tool = {
          layout = 'diff3_mixed',
          disable_diagnostics = true,
        },
      },
    },
  },

  -- 4. Git Conflict: Conflict resolution highlights
  {
    'akinsho/git-conflict.nvim',
    version = '*',
    config = true,
    opts = {
      default_mappings = true, -- uses co, ct, cb, c0
    },
  },
}
