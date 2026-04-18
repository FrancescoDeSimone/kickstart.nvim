return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'folke/snacks.nvim',
    },
    config = function()
      local neogit = require 'neogit'
      neogit.setup {
        disable_context_highlighting = false,
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
          section = { '', '' },
          item = { '', '' },
          hunk = { '', '' },
        },
      }

      local map = vim.keymap.set

      map('n', '<leader>gg', neogit.open, { desc = 'Neogit Status' })

      map('n', '<leader>gc', function() neogit.open { 'commit' } end, { desc = 'Git Commit' })
      map('n', '<leader>gp', function() neogit.open { 'pull' } end, { desc = 'Git Pull' })
      map('n', '<leader>gP', function() neogit.open { 'push' } end, { desc = 'Git Push' })

      map('n', '<leader>gb', function() neogit.open { 'branch' } end, { desc = 'Git Branches' })
      map('n', '<leader>gl', function() neogit.open { 'log' } end, { desc = 'Git Log' })
    end,
  },

  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre' },
    opts = {
      attach_to_untracked = false,
      watch_gitdir = { follow_files = true }, -- follow renames/branch switches
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
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select hunk' })
      end,
    },
  },

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

  {
    'akinsho/git-conflict.nvim',
    version = '*',
    config = true,
    opts = {
      default_mappings = true, -- uses co, ct, cb, c0
    },
  },
}
