-- return {
--   'madskjeldgaard/cppman.nvim',
--   requires = {
--     { 'MunifTanjim/nui.nvim' },
--   },
--   config = function()
--     local cppman = require 'cppman'
--     cppman.setup()
--
--     -- Make a keymap to open the word under cursor in CPPman
--     vim.keymap.set('n', '<leader>cm', function()
--       cppman.open_cppman_for(vim.fn.expand '<cword>')
--     end, { desc = 'Cppman' })
--
--     -- Open search box
--     vim.keymap.set('n', '<leader>cc', function()
--       cppman.input()
--     end)
--   end,
-- }
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
    -- The setup can remain here. It will run after the plugin loads.
    require('cppman').setup()
  end,
}
