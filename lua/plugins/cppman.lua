return {
  'madskjeldgaard/cppman.nvim',
  dependencies = { 'MunifTanjim/nui.nvim' },
  -- Use cmd to lazy-load until a command is run
  cmd = { 'Cppman' },
  keys = {
    {
      '<leader>cm',
      function()
        require('cppman').open_cppman_for(vim.fn.expand '<cword>')
      end,
      desc = 'Cppman: Word under cursor',
    },
    {
      '<leader>cc',
      function()
        require('cppman').input()
      end,
      desc = 'Cppman: Search',
    },
  },
  config = function()
    require('cppman').setup()
  end,
}
