-- lua/plugins/which-key.lua
return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    delay = 0,
    icons = {
      mappings = vim.g.have_nerd_font,
      keys = vim.g.have_nerd_font and {} or {
        ['<CR>'] = 'CR', ['<Esc>'] = 'Esc', ['<Space>'] = 'Space', ['<Tab>'] = 'Tab', -- and so on
      },
    },

    -- This spec table is now the central documentation for your keymaps
    spec = {
      -- Top-level groups
      { '<leader>c', group = '[C]ode' },
      { '<leader>g', group = '[G]it' },
      { '<leader>l', group = '[L]SP' },
      { '<leader>o', group = '[O]bsidian' },
      { '<leader>r', group = '[R]ename / [R]eformat' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>u', group = '[U]I Toggles' },
      { '<leader>x', group = '[D]iagnostics' },

      -- Individual keymap descriptions
      { '<leader><space>', desc = 'Search Buffers' },
      { '<leader>e', desc = 'File Explorer (Oil)' },
      { '<leader>q', desc = 'Close Buffer' },
      { '<leader>n', desc = 'Notification History' },
      { '<leader>Z', desc = 'Zen Mode' },
      { '<leader>z', desc = 'Zoom Window' },
      { '<leader>.', desc = 'Scratch Buffer' },
      { '<leader>S', desc = 'Select Scratch Buffer' },
      { '<leader>N', desc = 'Neovim News' },

      -- C: Code group
      { '<leader>cc', desc = 'Cppman Search' },
      { '<leader>cm', desc = 'Cppman Word' },

      -- G: Git group
      { '<leader>gB', desc = 'Git Browse (Snacks)' },
      { '<leader>gb', desc = 'Git Blame (Fugitive)' }, -- Renamed from gB to avoid conflict
      { '<leader>gc', desc = 'Git Commit' },
      { '<leader>gac', desc = 'Amend Commit' },
      { '<leader>gd', desc = 'Git Diff View' },
      { '<leader>gf', desc = 'Git Status (Fugitive)' },
      { '<leader>gg', desc = 'Find Git Files (Snacks)' },
      { '<leader>gl', desc = 'Git Log (Snacks)' },
      { '<leader>gL', desc = 'Git Log for Line (Snacks)' },
      { '<leader>gp', desc = 'Git Pull' },
      { '<leader>gP', desc = 'Git Push' },
      { '<leader>gr', desc = 'Revert Buffer (Gread)' },
      { '<leader>gs', desc = 'Git Status (Snacks)' },
      { '<leader>gS', desc = 'Git Stash (Snacks)' },
      -- G -> H: Gitsigns Hunk actions
      { '<leader>gh', group = 'Gitsigns [H]unk' },
      { '<leader>ghr', desc = 'Reset Hunk' },
      { '<leader>ghs', desc = 'Stage Hunk' },
      { '<leader>ghS', desc = 'Stage Buffer' },
      { '<leader>ghu', desc = 'Undo Stage Hunk' },
      { '<leader>ghR', desc = 'Reset Buffer' },
      { '<leader>ghp', desc = 'Preview Hunk' },

      -- L: LSP group
      { '<leader>la', desc = 'Code Action' },
      { '<leader>ld', desc = 'Peek Definition' },
      { '<leader>lf', desc = 'Finder' },
      { '<leader>li', desc = 'Incoming Calls' },
      { '<leader>lo', desc = 'Outgoing Calls' },
      { '<leader>ls', desc = 'Document Symbols' },

      -- O: Obsidian group
      { '<leader>oa', desc = 'List Daily Notes' },
      { '<leader>ob', desc = 'Show Backlinks' },
      { '<leader>oc', desc = 'Toggle Checkbox' },
      { '<leader>od', desc = "Today's Daily Note" },
      { '<leader>of', desc = 'Follow Link' },
      { '<leader>ol', desc = 'List Links in Note' },
      { '<leader>on', desc = 'New Note' },
      { '<leader>oo', desc = 'Open Note' },
      { '<leader>op', desc = 'Paste Image' },
      { '<leader>oq', desc = 'Quick Switch' },
      { '<leader>or', desc = 'Rename Note' },
      { '<leader>os', desc = 'Search Notes' },
      { '<leader>ot', group = 'Time/Tags' },
      { '<leader>ott', desc = 'List Notes by Tag' },
      { '<leader>otc', desc = 'Show Table of Contents' },
      { '<leader>otm', desc = "Tomorrow's Daily Note" },
      { '<leader>ow', desc = 'Switch Workspace' },
      { '<leader>oy', desc = "Yesterday's Daily Note" },

      -- R: Rename/Reformat group
      { '<leader>rr', desc = 'Rename Symbol (LSP Saga)' },
      { '<leader>rR', desc = 'Rename File (Snacks)' },
      { '<leader>rf', desc = 'Format File (Conform)' },
      { '<leader>rw', desc = 'Wrap at 80 columns' },

      -- S: Search group
      { '<leader>s/', desc = 'Grep (Live)' },
      { '<leader>/', desc = 'Search Buffer Lines' },
      { '<leader>sB', desc = 'Grep in Open Buffers' },
      { '<leader>sC', desc = 'Search Commands' },
      { '<leader>sf', desc = 'Find Files' },
      { '<leader>sh', desc = 'Search Help Pages' },
      { '<leader>sk', desc = 'Search Keymaps' },
      { '<leader>sm', desc = 'Search Marks' },
      { '<leader>sM', desc = 'Search Man Pages' },
      { '<leader>sP', desc = 'Search Projects' },
      { '<leader>sp', desc = 'Search Plugins (Lazy)' },
      { '<leader>sr', desc = 'Find/Replace Word' },
      { '<leader>sR', desc = 'Find/Replace in Project (Grug-far)' },
      { '<leader>su', desc = 'Search Undo History' },
      { '<leader>y', desc = 'Search Registers' }, -- Mapped to <leader>y

      -- T: Toggle group
      { '<leader>tb', desc = 'Toggle Blame Line' },
      { '<leader>tD', desc = 'Toggle Deleted Hunk' },
      { '<leader>th', desc = 'Toggle Inlay Hints' },
      { '<leader>tR', desc = 'Resume Last Search' },

      -- U: UI Toggles group (from snacks)
      { '<leader>ub', desc = 'Toggle Background' },
      { '<leader>uc', desc = 'Toggle Conceal' },
      { '<leader>ud', desc = 'Toggle Diagnostics' },
      { '<leader>uD', desc = 'Toggle Dim' },
      { '<leader>ug', desc = 'Toggle Indent Guides' },
      { '<leader>uh', desc = 'Toggle Inlay Hints' },
      { '<leader>ul', desc = 'Toggle Line Numbers' },
      { '<leader>uL', desc = 'Toggle Relative Numbers' },
      { '<leader>us', desc = 'Toggle Spelling' },
      { '<leader>uT', desc = 'Toggle Treesitter Highlight' },
      { '<leader>uw', desc = 'Toggle Wrap' },
      { '<leader>uC', desc = 'Colorschemes' }, -- Mapped to <leader>uC

      -- X: Diagnostics group
      { '<leader>xd', desc = 'Workspace Diagnostics' },
      { '<leader>xD', desc = 'Buffer Diagnostics' },
    },
  },
}
