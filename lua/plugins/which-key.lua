return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    preset = 'modern',
    delay = 0,
    icons = {
      mappings = true,
      group = ' ',
      separator = ' ',
      colors = true,
    },
    spec = {
      -- Programming
      { '<leader>p', group = '[P]rogramming', icon = { icon = ' ', color = 'orange' } },

      -- Run/Rename
      { '<leader>pr', group = '[R]un / Rename', icon = { icon = ' ', color = 'blue' } },

      -- Environment & Packages
      { '<leader>pv', group = '[V]env / Packages', icon = { icon = ' ', color = 'green' } },
      { '<leader>pve', desc = 'Manage Venv' },
      { '<leader>pva', desc = 'Add Package' },
      { '<leader>pvc', desc = 'Sync Packages' },

      -- C++ Reference
      { '<leader>c', group = '[C]++ Reference', icon = { icon = '󰙲 ', color = 'blue' } },
      { '<leader>cm', desc = 'Cppman: Word Under Cursor' },
      { '<leader>cc', desc = 'Cppman: Search' },

      -- Debug
      { '<leader>D', group = '[D]ebug', icon = { icon = '󰃤 ', color = 'red' } },

      -- Folds
      { '<leader>f', group = '[F]olds', icon = { icon = ' ', color = 'yellow' } },
      { '<leader>fo', desc = 'Toggle Fold' },
      { '<leader>fO', desc = 'Toggle All Folds' },
      { '<leader>fr', desc = 'Open All Folds' },
      { '<leader>fm', desc = 'Close All Folds' },

      -- Search
      { '<leader>s', group = '[S]earch', icon = { icon = ' ', color = 'green' } },
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
      { '<leader>sr', desc = 'Replace Word Under Cursor' },
      { '<leader>sR', desc = 'Search/Replace (Grug-far)' },
      { '<leader>ss', desc = 'LSP Symbols' },
      { '<leader>sS', desc = 'Workspace Symbols' },
      { '<leader>su', desc = 'Undo History' },

      -- Git
      { '<leader>g', group = '[G]it', icon = { icon = ' ', color = 'orange' } },
      { '<leader>gg', desc = 'Git Status' },
      { '<leader>gc', desc = 'Git Commit' },
      { '<leader>gp', desc = 'Git Pull' },
      { '<leader>gP', desc = 'Git Push' },
      { '<leader>gb', desc = 'Git Branches' },
      { '<leader>gl', desc = 'Git Log' },
      { '<leader>gd', desc = 'Diffview Open' },
      { '<leader>gD', desc = 'Diffview Close' },
      { '<leader>gB', desc = 'Git Browse' },
      { '<leader>gh', group = 'Git [H]unks', icon = { icon = '󰊢 ', color = 'orange' } },
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
      { '<leader>e', desc = 'File Explorer', icon = { icon = '󰙅 ', color = 'cyan' } },
      { '<leader>-', desc = 'File Explorer (Split)', icon = { icon = '󰙅 ', color = 'cyan' } },

      -- Buffers
      { '<leader>b', desc = 'Buffers', icon = { icon = '󰈔 ', color = 'cyan' } },
      { '<leader>q', desc = 'Delete Buffer', icon = { icon = '󰅖 ', color = 'red' } },

      -- Diagnostics
      { '<leader>x', group = '[X] Diagnostics', icon = { icon = '󱖫 ', color = 'green' } },
      { '<leader>xD', desc = 'Diagnostics' },
      { '<leader>xd', desc = 'Buffer Diagnostics' },
      { '<leader>xq', desc = 'Quickfix → Diagnostics' },
      { '<leader>xW', desc = 'LSP Workspace Diagnostics' },

      -- Replace/Refactor
      { '<leader>r', group = '[R]eplace/Refactor', icon = { icon = ' ', color = 'cyan' } },
      { '<leader>rw', desc = 'Wrap Line at 80 Chars' },
      { '<leader>rf', desc = 'Format Buffer' },
      { '<leader>rR', desc = 'Rename File' },
      { '<leader>rl', desc = 'Lint Buffer' },

      -- UI Toggles
      { '<leader>u', group = '[U]I', icon = { icon = '󰙵 ', color = 'cyan' } },

      -- Tools
      { '<leader>t', group = '[T]ools', icon = { icon = ' ', color = 'purple' } },
      { '<leader>tR', desc = 'Resume Picker' },
      { '<leader>tl', desc = 'Refresh Codelenses' },
      { '<leader>td', desc = 'Diff Tool' },

      -- Standalone keys with explicit icons
      { '<leader>z', desc = 'Toggle Zoom', icon = { icon = '󰁌 ', color = 'blue' } },
      { '<leader>Z', desc = 'Toggle Zen Mode', icon = { icon = '󱅻 ', color = 'cyan' } },
      { '<leader>.', group = 'Scratch', icon = { icon = '󰏫 ', color = 'yellow' } },
      { '<leader>.s', desc = 'Select Scratch Buffer' },
      { '<leader>S', group = '[S]ession', icon = { icon = ' ', color = 'azure' } },
      { '<leader>Ss', desc = 'Save Session' },
      { '<leader>Sl', desc = 'Load Session' },
      { '<leader>N', desc = 'Neovim News', icon = { icon = '󰎕 ', color = 'green' } },
      { '<leader>y', desc = 'Registers', icon = { icon = '󱓥 ', color = 'yellow' } },
      { '<leader>/', desc = 'Buffer Lines', icon = { icon = ' ', color = 'green' } },
      { '<leader>:', desc = 'Command History', icon = { icon = ' ', color = 'purple' } },
      { '<leader>n', desc = 'Notification History', icon = { icon = '󰵅 ', color = 'blue' } },
      { '<leader><leader>', desc = 'Peep', icon = { icon = '󰈈 ', color = 'yellow' } },

      -- Nvim 0.12 default LSP keymaps (documented here for discoverability)
      { 'grn', desc = 'LSP Rename' },
      { 'gra', desc = 'LSP Code Action', mode = { 'n', 'v' } },
      { 'grr', desc = 'LSP References' },
      { 'gri', desc = 'LSP Implementation' },
      { 'grt', desc = 'LSP Type Definition' },
      { 'grx', desc = 'LSP Run Codelens' },
      { 'gO',  desc = 'LSP Document Symbols' },
      { 'gx',  desc = 'Open link / LSP documentLink' },
    },
  },
}
