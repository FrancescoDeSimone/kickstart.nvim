return {
  {
    'igorlfs/nvim-dap-view',
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {},
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio', -- Required for dapui
      'jbyuki/one-small-step-for-vimkind',
      'mfussenegger/nvim-dap-python',
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
      'leoluz/nvim-dap-go',
      -- nvim-dap-rr is listed separately below, but it's also a dependency
    },
    keys = {
      -- Standard DAP Keymaps (Based on the guide and your initial global maps)
      {
        '<F1>',
        function()
          require('dap').terminate()
        end,
        desc = 'Debug: Terminate/Stop',
      },
      {
        '<F6>',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Debug: Toggle Breakpoint',
      },
      {
        '<F7>',
        function()
          -- This will be overridden by nvim-dap-rr during rr sessions
          require('dap').continue()
        end,
        desc = 'Debug: Continue',
      },
      {
        '<F8>',
        function()
          -- This will be overridden by nvim-dap-rr during rr sessions
          require('dap').step_over()
        end,
        desc = 'Debug: Step Over',
      },
      {
        '<F9>',
        function()
          -- This will be overridden by nvim-dap-rr during rr sessions
          require('dap').step_out()
        end,
        desc = 'Debug: Step Out',
      },
      {
        '<F10>',
        function()
          -- This will be overridden by nvim-dap-rr during rr sessions
          require('dap').step_into()
        end,
        desc = 'Debug: Step Into',
      },
      {
        '<F11>',
        function()
          require('dap').pause()
        end,
        desc = 'Debug: Pause',
      },
      -- Use <A-key> notation which might be more portable than <F56>/<F57>
      -- If <A-F8>/<A-F9> don't work in your terminal, you might need
      -- to find the correct keycodes or use different bindings.
      {
        '<A-F8>', -- Alt+F8 (Often sends <F56> or similar, check your terminal)
        function()
          require('dap').down()
        end,
        desc = 'Debug: Go Down Stack Frame',
      },
      {
        '<A-F9>', -- Alt+F9 (Often sends <F57> or similar, check your terminal)
        function()
          require('dap').up()
        end,
        desc = 'Debug: Go Up Stack Frame',
      },
      -- Conditional Breakpoint
      {
        '<leader>b',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Debug: Toggle Breakpoint',
      },
      {
        '<leader>B',
        function()
          require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Debug: Set Conditional Breakpoint',
      },
      -- Toggle DAP UI (Changed from F7 to avoid conflict with dap.continue)
      {
        '<F12>', -- Or choose another key like '<leader>du'
        function()
          require('dapui').toggle()
        end,
        desc = 'Debug: Toggle DAP UI',
      },
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      -- Configure cppdbg adapter for nvim-dap-rr
      -- Assumes you have cpptools installed via mason
      local cpptools_path = vim.fn.stdpath 'data' .. '/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7'
      if vim.fn.executable(cpptools_path) == 1 then
        dap.adapters.cppdbg = {
          id = 'cppdbg',
          type = 'executable',
          command = cpptools_path,
          options = {
            detached = false, -- Adjust if needed, but often works best attached
          },
        }
      else
        vim.notify('cpptools adapter not found at: ' .. cpptools_path .. '\nPlease install it via Mason (`:MasonInstall cpptools`)', vim.log.levels.WARN)
      end

      -- Setup mason-nvim-dap
      require('mason-nvim-dap').setup {
        automatic_installation = true,
        handlers = {},
        ensure_installed = {
          -- Add cpptools needed by nvim-dap-rr
          'debugpy',
          'cpptools',
          'codelldb',
          'delve', -- For Go debugging
          -- Add other debug adapters you need, e.g., 'debugpy' for Python
        },
      }

      -- Dap UI setup
      dapui.setup {
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          enabled = true, -- Show controls in DAP UI window
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b', -- Note: step_back requires specific adapter support
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
          },
        },
        layouts = {
          {
            elements = {
              { id = 'scopes', size = 0.35 },
              { id = 'breakpoints', size = 0.15 },
              { id = 'stacks', size = 0.25 },
              { id = 'watches', size = 0.25 },
            },
            size = 0.3, -- Adjust width/height of the side/bottom panel
            position = 'left', -- 'left', 'right', 'bottom', 'top'
          },
          {
            elements = {
              { id = 'repl', size = 0.5 },
              { id = 'console', size = 0.5 },
            },
            size = 0.25, -- Adjust height/width of the other panel
            position = 'bottom',
          },
        },
        floating = {
          max_height = nil, -- Use fixed height for floating window
          max_width = nil, -- Use fixed width for floating window
          border = 'rounded',
          mappings = {
            close = { 'q', '<Esc>' },
          },
        },
        render = {
          max_type_length = nil, -- Maximum length of variables' types
        },
      }

      -- Auto open/close dapui
      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close

      -- Install language-specific DAP configs
      -- Go
      require('dap-go').setup {
        delve = {
          detached = vim.fn.has 'win32' == 0,
        },
      }
      -- Python (Example using mfussenegger/nvim-dap-python)
      -- require('dap-python').setup('python') -- Adjust path if needed

      -- Add rr configurations (ensure this runs *after* cppdbg adapter is defined)
      local rr_dap = require 'nvim-dap-rr' -- Ensure nvim-dap-rr is loaded
      if dap.adapters.cppdbg then -- Only add if cppdbg adapter exists
        if not dap.configurations.rust then
          dap.configurations.rust = {}
        end
        table.insert(dap.configurations.rust, rr_dap.get_rust_config())

        if not dap.configurations.cpp then
          dap.configurations.cpp = {}
        end
        table.insert(dap.configurations.cpp, rr_dap.get_config())
      else
        vim.notify('nvim-dap-rr configurations not added because cppdbg adapter is missing.', vim.log.levels.WARN)
      end

      -- Optional: Configure breakpoint signs (example)
      vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = 'Error', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '❓', texthl = 'WarningMsg', linehl = '', numhl = '' })
      vim.fn.sign_define('DapLogPoint', { text = '🪵', texthl = 'Debug', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '▶️', texthl = 'DiffAdd', linehl = 'CursorLine', numhl = 'CursorLine' })
    end,
  },

  {
    'jonboh/nvim-dap-rr',
    -- Ensure nvim-dap is listed if not implicitly handled by your plugin manager
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-telescope/telescope.nvim' },
    config = function()
      require('nvim-dap-rr').setup {
        mappings = {
          -- These keys should match your standard DAP keys for forward actions
          continue = '<F7>',
          step_over = '<F8>',
          step_out = '<F9>',
          step_into = '<F10>',
          -- Reverse actions (Shift + standard keys)
          reverse_continue = '<F19>', -- <S-F7>
          reverse_step_over = '<F20>', -- <S-F8>
          reverse_step_out = '<F21>', -- <S-F9>
          reverse_step_into = '<F22>', -- <S-F10>
          -- Instruction level stepping (Ctrl + standard keys)
          step_over_i = '<F32>', -- <C-F8>
          step_out_i = '<F33>', -- <C-F9> (Corrected from guide's C-F8)
          step_into_i = '<F34>', -- <C-F10> (Corrected from guide's C-F8)
          -- Reverse instruction level stepping (Shift + Ctrl + standard keys)
          reverse_step_over_i = '<F44>', -- <SC-F8>
          reverse_step_out_i = '<F45>', -- <SC-F9>
          reverse_step_into_i = '<F46>', -- <SC-F10>
        },
      }
    end,
  },

  {
    'theHamsta/nvim-dap-virtual-text',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-treesitter/nvim-treesitter' },
    setup = {
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
      highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
      show_stop_reason = true, -- show stop reason when stopped for exceptions
      commented = true, -- prefix virtual text with comment string
      only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
      all_references = false, -- show virtual text on all all references of the variable (not only definitions)
      clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
      display_callback = function(variable, buf, stackframe, node, options)
        -- by default, strip out new line characters
        if options.virt_text_pos == 'inline' then
          return ' = ' .. variable.value:gsub('%s+', ' ')
        else
          return variable.name .. ' = ' .. variable.value:gsub('%s+', ' ')
        end
      end,
      -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
      virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
      all_frames = true, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
      virt_lines = true, -- show virtual lines instead of virtual text (will flicker!)
      virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
    },
  },
}
