local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local conf = require('telescope.config').values
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'

local function get_program()
  return coroutine.create(function(coro)
    local opts = {}
    pickers
      .new(opts, {
        prompt_title = 'Path to executable',
        finder = finders.new_oneshot_job({ 'fd', '--exclude', '.git', '--no-ignore', '--type', 'x' }, {}),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(buffer_number)
          actions.select_default:replace(function()
            actions.close(buffer_number)
            coroutine.resume(coro, action_state.get_selected_entry()[1])
          end)
          return true
        end,
      })
      :find()
  end)
end
local dap = require 'dap'

dap.configurations.rust = {
  {
    name = '(lldb) Launch file',
    type = 'codelldb',
    request = 'launch',
    program = get_program,
  },
  {
    name = '(gdb) Launch file',
    type = 'cppdbg',
    request = 'launch',
    program = get_program,
  },
}

dap.configurations.cpp = {
  {
    name = '(lldb) Launch file',
    type = 'codelldb',
    request = 'launch',
    program = get_program,
    -- cwd = vim.fn.getcwd,
    -- stopOnEntry = true,
  },
  {
    name = '(gdb) Launch file',
    type = 'cppdbg',
    request = 'launch',
    program = get_program,
    -- cwd = vim.fn.getcwd,
    -- stopAtEntry = true,
  },
}

dap.configurations.c = dap.configurations.cpp
require('dap-python').setup 'uv'
table.insert(require('dap').configurations.python, {
  type = 'python',
  request = 'launch',
  name = 'My custom launch configuration',
  program = '${file}',
})

dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = 'Attach to running Neovim instance',
  },
}

dap.adapters.nlua = function(callback, config)
  callback { type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086 }
end
