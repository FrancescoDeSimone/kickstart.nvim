return {
  dir = '/home/fdesi/git/rfc.nvim',
  config = function()
    require('rfc').setup {
      picker = 'snacks', -- or 'snacks'
      notification = true, -- Enable/disable notifications
    }
  end,
}
