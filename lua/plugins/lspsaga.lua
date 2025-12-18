return {
  'nvimdev/lspsaga.nvim',
  config = function()
    require('lspsaga').setup {}
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  keys = {
    { '<leader>pa', '<cmd>Lspsaga code_action<CR>', desc = 'Code Action' },
    { '<leader>prn', '<cmd>Lspsaga rename<CR>', desc = 'Rename Symbol' },
    { '<leader>pD', '<cmd>Lspsaga peek_definition<CR>', desc = 'Peek Definition' },
  },
}
