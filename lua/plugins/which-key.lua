return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    delay = 0,
    icons = { mappings = true },
    spec = {
      -- Programming
      { '<leader>p', group = '[P]rogramming' },
      { '<leader>pa', desc = 'Code [A]ction' },
      { '<leader>pf', desc = 'Format File' },

      -- Debug
      { '<leader>D', group = '[D]ebug' },

      -- Run/Rename
      { '<leader>pr', group = '[R]un / Rename' },
      { '<leader>prr', desc = 'Run Current File' },
      { '<leader>prn', desc = 'Rename Symbol' },

      -- Environment & Packages
      { '<leader>pv', group = '[V]env / Packages' },
      { '<leader>pve', desc = 'Manage Venv' },
      { '<leader>pva', desc = 'Add Package' },
      { '<leader>pvc', desc = 'Sync Packages' },

      -- Search
      { '<leader>s', group = '[S]earch' },
      { '<leader>sf', desc = 'Find Files' },
      { '<leader>s/', desc = 'Live Grep' },
      { '<leader>sB', desc = 'Grep Buffers' },
      { '<leader>sC', desc = 'Commands' },
      { '<leader>sh', desc = 'Help' },
      { '<leader>sk', desc = 'Keymaps' },
      { '<leader>sl', desc = 'Location List' },
      { '<leader>sm', desc = 'Marks' },
      { '<leader>sM', desc = 'Man Pages' },
      { '<leader>sp', desc = 'Projects' },
      { '<leader>ss', desc = 'LSP Symbols' },
      { '<leader>sS', desc = 'Workspace Symbols' },
      { '<leader>su', desc = 'Undo History' },
      { '<leader>sR', desc = 'Resume Picker' },

      -- Git
      { '<leader>g', group = '[G]it' },
      { '<leader>gg', desc = 'Git Status' },
      { '<leader>gc', desc = 'Git Commit' },
      { '<leader>gp', desc = 'Git Pull' },
      { '<leader>gP', desc = 'Git Push' },
      { '<leader>gb', desc = 'Git Branches' },
      { '<leader>gl', desc = 'Git Log' },
      { '<leader>gd', desc = 'Diffview Open' },
      { '<leader>gD', desc = 'Diffview Close' },
      { '<leader>gB', desc = 'Git Browse' },
      { '<leader>gh', group = 'Git [H]unks' },
      { '<leader>ghs', desc = 'Stage Hunk' },
      { '<leader>ghr', desc = 'Reset Hunk' },
      { '<leader>ghS', desc = 'Stage Buffer' },
      { '<leader>ghu', desc = 'Undo Stage Hunk' },
      { '<leader>ghR', desc = 'Reset Buffer' },
      { '<leader>ghp', desc = 'Preview Hunk' },
      { '<leader>ghb', desc = 'Blame Line' },
      { '<leader>ght', desc = 'Toggle Blame' },
      { '<leader>ghd', desc = 'Diff This' },
      { '<leader>ghf', desc = 'File History (Current)' },
      { '<leader>ghF', desc = 'File History (All)' },

      -- Explorer
      { '<leader>e', group = '[E]xplorer' },
      { '<leader>e', desc = 'File Explorer' },
      { '<leader>-', desc = 'File Explorer (Split)' },

      -- Buffers
      { '<leader>b', group = '[B]uffers' },
      { '<leader>b', desc = 'Buffers' },
      { '<leader>q', desc = 'Delete Buffer' },

      -- UI/Toggles
      { '<leader>u', group = '[U]I/Toggles' },
      { '<leader>us', desc = 'Toggle Spelling' },
      { '<leader>uw', desc = 'Toggle Wrap' },
      { '<leader>uL', desc = 'Toggle Relative Number' },
      { '<leader>ud', desc = 'Toggle Diagnostics' },
      { '<leader>ul', desc = 'Toggle Line Number' },
      { '<leader>uc', desc = 'Toggle Conceal' },
      { '<leader>uT', desc = 'Toggle Treesitter' },
      { '<leader>uh', desc = 'Toggle Inlay Hints' },
      { '<leader>ug', desc = 'Toggle Indent' },
      { '<leader>uD', desc = 'Toggle Dim' },
      { '<leader>uf', desc = 'Toggle Autoformat' },
      { '<leader>un', desc = 'Dismiss Notifications' },
      { '<leader>uC', desc = 'Colorschemes' },

      -- Diagnostics
      { '<leader>x', group = '[X] Diagnostics' },
      { '<leader>xD', desc = 'Diagnostics' },
      { '<leader>xd', desc = 'Buffer Diagnostics' },

      -- Replace/Refactor
      { '<leader>r', group = '[R]eplace/Refactor' },
      { '<leader>rw', desc = 'Wrap Line at 80 Chars' },
      { '<leader>sr', desc = 'Replace Word' },
      { '<leader>sR', desc = 'Search/Replace' },
      { '<leader>rf', desc = 'Format Buffer' },
      { '<leader>rR', desc = 'Rename File' },

      -- Utilities
      { '<leader>t', group = '[T]ools' },
      { '<leader>z', desc = 'Toggle Zoom' },
      { '<leader>Z', desc = 'Toggle Zen Mode' },
      { '<leader>.', desc = 'Scratch Buffer' },
      { '<leader>S', desc = 'Select Scratch' },
      { '<leader>N', desc = 'Neovim News' },
      { '<leader>y', desc = 'Registers' },
      { '<leader>/', desc = 'Buffer Lines' },
      { '<leader>:', desc = 'Command History' },
      { '<leader>n', desc = 'Notification History' },
      { '<leader>tR', desc = 'Resume Picker' },
    },
  },
}

