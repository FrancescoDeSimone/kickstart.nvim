return {
  'avante-corp/avante.nvim',
  event = 'VeryLazy',
  build = 'make',
  version = false,
  opts = {
    provider = 'llamacpp',
    providers = {
      llamacpp = {
        __inherited_from = 'openai',
        endpoint = 'http://127.0.0.1:8765/v1',
        model = 'qwen3-local',
        api_key_name = '',
        timeout = 120000,
        context_window = 16384,
        extra_request_body = { temperature = 0.2, top_p = 0.95, max_tokens = 4096 },
      },
    },
    input = { provider = 'snacks' },
    selector = { provider = 'snacks' },
    windows = { width = 60 },
    behaviour = { auto_set_keymaps = false },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'folke/snacks.nvim',
    'echasnovski/mini.icons',
  },
  config = function(_, opts)
    require('avante').setup(opts)

    local api = require 'avante.api'
    local keymap = vim.keymap.set
    local Snacks = require 'snacks'

    keymap('n', '<leader>at', '<cmd>AvanteToggle<CR>', { desc = 'Toggle Avante' })
    keymap('n', '<leader>ac', '<cmd>AvanteClear<CR>', { desc = 'Clear Avante Chat' })

    keymap({ 'n', 'v' }, '<leader>aa', api.ask, { desc = 'Ask Avante' })
    keymap({ 'n', 'v' }, '<leader>ar', function()
      api.ask { question = 'Refactor this code' }
    end, { desc = 'Refactor with Avante' })
    keymap({ 'n', 'v' }, '<leader>af', function()
      api.ask { question = 'Fix this code' }
    end, { desc = 'Fix with Avante' })
    keymap({ 'n', 'v' }, '<leader>ae', api.edit, { desc = 'Edit Buffer with Avante' })

    keymap('n', '<leader>ao', '<cmd>AvanteSwitchProvider<CR>', { desc = 'Avante Provider' })
    keymap('n', '<leader>ad', '<cmd>checkhealth avante<CR>', { desc = 'Avante Health' })
    keymap({ 'n', 'v' }, '<leader>ax', function()
      api.toggle.debug()
    end, { desc = 'Toggle Avante Debug' })

    keymap({ 'n', 't' }, '<leader>aT', function()
      Snacks.terminal.toggle()
    end, { desc = 'Toggle Terminal' })
  end,
}
