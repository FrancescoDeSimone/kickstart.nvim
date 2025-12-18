return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    delay = 0,
    icons = { mappings = true },
    spec = {
      { '<leader>p', group = '[P]rogramming' },
      { '<leader>pa', desc = 'Code [A]ction' }, -- Unified (Lspsaga/LSP)
      { '<leader>pf', desc = 'Format File' }, -- Unified (Conform)

      -- Debug Group (Matches IntelliJ actions)
      { '<leader>pd', group = '[D]ebug' },
      { '<leader>pdd', desc = 'Start/Continue' }, -- F9
      { '<leader>pdb', desc = 'Toggle Breakpoint' }, -- Ctrl+F8
      { '<leader>pdi', desc = 'Step Into' }, -- F7
      { '<leader>pdo', desc = 'Step Over' }, -- F8
      { '<leader>pdt', desc = 'Terminate' }, -- Ctrl+F2
      { '<leader>pdu', desc = 'Toggle Debug UI' },

      -- Run/Rename Group
      { '<leader>pr', group = '[R]un / Rename' },
      { '<leader>prr', desc = 'Run Current File' }, -- uv run
      { '<leader>prn', desc = 'Rename Symbol' }, -- Lspsaga rename

      -- Environment & Packages (Agnostic)
      { '<leader>pv', group = '[V]env / Packages' },
      { '<leader>pve', desc = 'Manage Venv' },
      { '<leader>pva', desc = 'Add Package' },
      { '<leader>pvc', desc = 'Sync Packages' },

      -- Diagnostics Group
      { '<leader>x', group = '[X] Diagnostics' },
    },
  },
}
