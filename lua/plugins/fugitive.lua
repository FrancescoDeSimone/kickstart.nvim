local map = vim.keymap.set
map('n', '<leader>gf', ':Git<CR>', { desc = 'Fugitive: Open Git Status' })
map('n', '<leader>gs', ':Gwrite<CR>', { desc = 'Fugitive: Stage Current File (Gwrite)' })
map('n', '<leader>gd', ':Gvdiffsplit<CR>', { desc = 'Fugitive: Vertical Diff Staged vs Worktree' })
map('n', '<leader>gc', ':Git commit<CR>', { desc = 'Fugitive: Commit' })
map('n', '<leader>gac', ':Git commit --amend<CR>', { desc = 'Fugitive: Amend Previous Commit' })
map('n', '<leader>gP', ':Git push<CR>', { desc = 'Fugitive: Push' })
map('n', '<leader>gp', ':Git pull<CR>', { desc = 'Fugitive: Pull' })
map('n', '<leader>gB', ':Git blame<CR>', { desc = 'Fugitive: Blame Current File' })
map('n', '<leader>gr', ':Gread<CR>', { desc = 'Fugitive: Revert Buffer to HEAD (Gread)' })
-- map('n', '<leader>gg', ':Ggrep ', { noremap = true, desc = 'Fugitive: Grep (git grep)' })
return {
  'tpope/vim-fugitive',
  -- dependencies = { 'tpope/vim-rhubarb' },
}
