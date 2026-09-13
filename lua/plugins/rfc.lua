return {
  -- dir = '/home/fdesi/git/rfc.nvim',
  'FrancescoDeSimone/rfc.nvim',
  cmd = 'RFC',
  config = function()
    require('rfc').setup {
      picker = 'snacks',
      verbose = false,
    }
  end,
}
