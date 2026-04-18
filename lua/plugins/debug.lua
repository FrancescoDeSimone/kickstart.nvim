return {
  {
    'mfussenegger/nvim-dap',
    keys = {
      { '<leader>Dt', desc = 'Toggle Debug Mode' },
      { '<F5>', desc = 'DAP Continue' },
      { '<F10>', desc = 'DAP Step Over' },
      { '<F11>', desc = 'DAP Step Into' },
      { '<F12>', desc = 'DAP Step Out' },
    },
    cmd = {
      'DapContinue',
      'DapToggleBreakpoint',
      'DapStepOver',
      'DapStepInto',
      'DapStepOut',
      'DapTerminate',
      'DapREPL',
    },
    ft = { 'rust', 'go', 'python', 'lua', 'cpp', 'c' },
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
          vim.keymap.set('n', '<F5>', dap.continue, { desc = 'DAP Continue' })
          vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'DAP Step Over' })
          vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'DAP Step Into' })
          vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'DAP Step Out' })
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

      {
        'andrewferrier/debugprint.nvim',
        config = function()
          require('debugprint').setup()
        end,
      },
      'lucaSartore/nvim-dap-exception-breakpoints',
      {
        'igorlfs/nvim-dap-view',
        lazy = false,
        version = '1.*',
        ---@module 'dap-view'
        ---@type dapview.Config
        opts = {
          virtual_text = {
            enabled = true,
          },
          auto_toggle = true,
          winbar = {
            sections = { 'watches', 'scopes', 'exceptions', 'breakpoints', 'threads', 'repl', 'console' },
          },
        },
      },
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

      local dap_signs = {
        DapBreakpoint = { text = '🛑', texthl = 'Error' },
        DapBreakpointCondition = { text = '❓', texthl = 'WarningMsg' },
        DapStopped = { text = '▶️', texthl = 'DiffAdd', linehl = 'CursorLine' },
      }
      for name, sign in pairs(dap_signs) do
        vim.fn.sign_define(name, sign)
      end

      local edit_exception_breakpoints = require 'nvim-dap-exception-breakpoints'
      vim.keymap.set('n', '<leader>De', edit_exception_breakpoints, { desc = 'DAP Edit Exception Breakpoints' })
    end,
  },
}
