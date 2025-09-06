return {
  'tpope/vim-fugitive',
  keys = {
    { '<leader>gf', '<cmd>Git<CR>', desc = 'Fugitive: Open Git Status' },
    { '<leader>gs', '<cmd>Gwrite<CR>', desc = 'Fugitive: Stage Current File (Gwrite)' },
    { '<leader>gd', '<cmd>Gvdiffsplit<CR>', desc = 'Fugitive: Vertical Diff Staged vs Worktree' },
    { '<leader>gc', '<cmd>Git commit<CR>', desc = 'Fugitive: Commit' },
    { '<leader>gac', '<cmd>Git commit --amend<CR>', desc = 'Fugitive: Amend Previous Commit' },
    { '<leader>gP', '<cmd>Git push<CR>', desc = 'Fugitive: Push' },
    { '<leader>gp', '<cmd>Git pull<CR>', desc = 'Fugitive: Pull' },
    { '<leader>gB', '<cmd>Git blame<CR>', desc = 'Fugitive: Blame Current File' },
    { '<leader>gr', '<cmd>Gread<CR>', desc = 'Fugitive: Revert Buffer to HEAD (Gread)' },
  },
}
