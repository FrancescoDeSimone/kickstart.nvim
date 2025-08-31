vim.keymap.set('n', '<leader>li', ':Lspsaga incoming_calls<CR>', { desc = 'Incoming calls' })
vim.keymap.set('n', '<leader>lo', ':Lspsaga outgoing_calls<CR>', { desc = 'Outgoing calls' })
vim.keymap.set('n', '<leader>la', ':Lspsaga code_action<CR>', { desc = 'Code action' })
vim.keymap.set('n', '<leader>lf', ':Lspsaga finder<CR>', { desc = 'Finder' })
vim.keymap.set('n', '<leader>ls', ':Lspsaga outline<CR>', { desc = 'symbol outline' })
vim.keymap.set('n', '<leader>ld', ':Lspsaga peek_definition<CR>', { desc = 'Peek definition' })
vim.keymap.set('n', '<leader>rr', ':Lspsaga rename<CR>', { desc = 'Rename' })
return {
  'nvimdev/lspsaga.nvim',
  config = function()
    require('lspsaga').setup {}
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    -- 'nvim-tree/nvim-web-devicons', -- optional
  },
}
