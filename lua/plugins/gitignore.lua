return {
  'wintermute-cell/gitignore.nvim',
  cmd = 'Gitignore',
  keys = {
    {
      '<leader>gi',
      function()
        require 'gitignore'
      end,
      desc = 'Generate .gitignore',
    },
  },
  config = function()
    require 'gitignore'
  end,
}
