return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'jay-babu/mason-nvim-dap.nvim',
      {
        'MironPascalCaseFan/debugmaster.nvim',
        dependencies = {
          'nvim-treesitter/nvim-treesitter',
          'jbyuki/one-small-step-for-vimkind',
        },
        config = function()
          local dm = require 'debugmaster'
          local dap = require 'dap'

          dm.plugins.osv_integration.enabled = true

          dm.keys.add {
            key = 'p',
            desc = 'Toggle Exec Direction (RR)',
            action = (function()
              local dir = 'forward'
              return function()
                local s = dap.session()
                if not s then
                  return vim.notify('No active session', vim.log.levels.WARN)
                end
                dir = (dir == 'forward' and 'reverse' or 'forward')
                s:evaluate('-exec set exec-direction ' .. dir)
                vim.notify('Execution Direction: ' .. dir:upper(), vim.log.levels.INFO)
              end
            end)(),
          }

          vim.keymap.set('n', '<leader>Dt', dm.mode.toggle, { desc = 'Toggle Debug Mode' })
          vim.keymap.set('t', '<C-\\>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
        end,
      },

      {
        'jonboh/nvim-dap-rr',
        config = function()
          local rr_dap = require 'nvim-dap-rr'
          rr_dap.setup {}

          local dap = require 'dap'
          dap.configurations.rust = { rr_dap.get_rust_config() }
          dap.configurations.cpp = { rr_dap.get_config() }
        end,
      },

      'mfussenegger/nvim-dap-python', -- Python
      'leoluz/nvim-dap-go', -- Go

      'andrewferrier/debugprint.nvim',
      'lucaSartore/nvim-dap-exception-breakpoints',
      'theHamsta/nvim-dap-virtual-text',
    },

    config = function()
      local dap = require 'dap'

      require('mason-nvim-dap').setup {
        automatic_installation = true,
        ensure_installed = {
          'codelldb',
          'cpptools',
          'debugpy',
          'delve',
        },
      }

      local debugpy_path = vim.fn.stdpath 'data' .. '/mason/packages/debugpy/venv/bin/python'
      require('dap-python').setup(debugpy_path)

      require('dap-go').setup()

      local cpptools_path = vim.fn.stdpath 'data' .. '/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7'
      dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = cpptools_path,
      }

      -- Nvim 0.12: use dap.defaults for sign configuration (replaces vim.fn.sign_define)
      local dap_signs = {
        DapBreakpoint = { text = '🛑', texthl = 'Error' },
        DapBreakpointCondition = { text = '❓', texthl = 'WarningMsg' },
        DapStopped = { text = '▶️', texthl = 'DiffAdd', linehl = 'CursorLine' },
      }
      for name, sign in pairs(dap_signs) do
        vim.fn.sign_define(name, sign)
      end
    end,
  },
}
