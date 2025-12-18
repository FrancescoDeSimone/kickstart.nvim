return {
  'benomahony/uv.nvim',
  ft = 'python',
  opts = {
    keymaps = {
      prefix = '<leader>pv', -- Moves package management to [P]rogramming [V]env/Packages
      venv = 'e', -- Becomes <leader>pve
      add = 'a', -- Becomes <leader>pva
      sync = 'c', -- Becomes <leader>pvc
    },
  },
}
