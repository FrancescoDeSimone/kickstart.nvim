return {
  'nickjvandyke/opencode.nvim',
  dependencies = {
    {
      'folke/snacks.nvim',
      optional = true,
      opts = {
        input = {},
        picker = {
          actions = {
            opencode_send = function(...)
              return require('opencode').snacks_picker_send(...)
            end,
          },
          win = {
            input = {
              keys = {
                ['<a-a>'] = { 'opencode_send', mode = { 'n', 'i' } },
              },
            },
          },
        },
      },
    },
  },
  config = function()
    vim.g.opencode_opts = {}
    vim.o.autoread = true

    vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
      require('opencode').ask('@this: ', { submit = true })
    end, { desc = 'Ask OpenCode' })

    vim.keymap.set({ 'n', 'x' }, '<leader>os', function()
      require('opencode').select()
    end, { desc = 'Select OpenCode Action' })

    vim.keymap.set({ 'n', 't' }, '<leader>ot', function()
      require('opencode').toggle()
    end, { desc = 'Toggle OpenCode' })

    vim.keymap.set({ 'n', 'x' }, '<leader>or', function()
      return require('opencode').operator('@this ')
    end, { desc = 'Add Range to OpenCode', expr = true })
  end,
}
