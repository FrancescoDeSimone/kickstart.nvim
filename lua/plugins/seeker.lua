return {
  '2kabhishek/seeker.nvim',
  dependencies = { 'folke/snacks.nvim' },
  cmd = { 'Seeker' },
  keys = {
    { '<leader>sf', '<cmd>Seeker<CR>', desc = 'Seek Files' },
    { '<leader>s/', '<cmd>Seeker grep<CR>', desc = 'Seek Grep' },
    { '<leader>sg', '<cmd>Seeker git_files<CR>', desc = 'Seek Git Files' },
  },
  opts = {
    toggle_key = '<C-e>',
    picker_opts = {},
  },
}
