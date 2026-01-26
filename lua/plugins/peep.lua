return {
  'lum1nar/peep.nvim',
  opts = {
    fg_color = '#ffdd33',
    bg_color = '#282828',
    peep_duration = 800,
  },
  keys = {
    {
      '<leader><leader>',
      mode = { 'n', 'v' },
      function()
        require('peep').peep()
      end,
      desc = 'Peep',
    },
  },
}
