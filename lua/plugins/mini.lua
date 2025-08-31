return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    -- require('mini.ai').setup { n_lines = 500 }
    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    -- require('mini.surround').setup {}
    require('mini.cursorword').setup()
    require('mini.bracketed').setup()
    require('mini.pick').setup()
    -- In your plugins configuration file where mini.clue is set up:
    -- local miniclue = require 'mini.clue'
    -- miniclue.setup {
    --   triggers = {
    --     -- Leader triggers
    --     { mode = 'n', keys = '<Leader>' },
    --     { mode = 'x', keys = '<Leader>' },
    --
    --     -- -- Built-in completion
    --     -- { mode = 'i', keys = '<C-x>' },
    --
    --     -- `g` key
    --     { mode = 'n', keys = 'g' },
    --     { mode = 'x', keys = 'g' },
    --
    --     -- Marks
    --     { mode = 'n', keys = "'" },
    --     { mode = 'n', keys = '`' },
    --     { mode = 'x', keys = "'" },
    --     { mode = 'x', keys = '`' },
    --
    --     -- Registers
    --     { mode = 'n', keys = '"' },
    --     { mode = 'n', keys = 's' },
    --     { mode = 'x', keys = '"' },
    --     { mode = 'i', keys = '<C-R>' },
    --     { mode = 'c', keys = '<C-R>' },
    --
    --     -- Window commands
    --     { mode = 'n', keys = '<C-w>' },
    --
    --     -- `z` key
    --     { mode = 'n', keys = 'z' },
    --     { mode = 'x', keys = 'z' },
    --     -- brackets
    --     { mode = 'n', keys = ']' },
    --     { mode = 'n', keys = '[' },
    --   },
    --   window = {
    --     delay = 10,
    --     scroll_down = '<C-d>',
    --     scroll_up = '<C-u>',
    --     config = {
    --       border = 'rounded',
    --       width = 60,
    --     },
    --   },
    --   clues = {
    --     miniclue.gen_clues.builtin_completion(),
    --     miniclue.gen_clues.g(),
    --     miniclue.gen_clues.marks(),
    --     miniclue.gen_clues.registers {
    --       -- show_contents = true,
    --     },
    --     miniclue.gen_clues.windows {
    --       submode_move = true,
    --       submode_navigate = true,
    --       submode_resize = true,
    --     },
    --     miniclue.gen_clues.z(),
    --     { mode = 'n', keys = ']b', postkeys = ']' },
    --     { mode = 'n', keys = ']w', postkeys = ']' },
    --     { mode = 'n', keys = '[b', postkeys = '[' },
    --     { mode = 'n', keys = '[w', postkeys = '[' },
    --
    --     { mode = 'n', keys = '<Leader>o', desc = '+Obsidian' },
    --     { mode = 'n', keys = '<Leader>x', desc = '+Trouble' },
    --     { mode = 'n', keys = '<Leader>u', desc = '+UI' },
    --     { mode = 'n', keys = '<Leader>g', desc = '+Git' },
    --     { mode = 'n', keys = '<Leader>s', desc = '+Search' },
    --     { mode = 'n', keys = '<Leader>l', desc = '+LSP' },
    --     { mode = 'n', keys = '<Leader>r', desc = '+Refactor' },
    --     { mode = 'n', keys = '<Leader>c', desc = '+CPP' },
    --   },
    -- }

    require('mini.trailspace').setup()
    require('mini.move').setup {
      mappings = {
        left = '<M-Left>',
        right = ' <M-Right>',
        down = '<M-Down>',
        up = ' <M-Up>',
        line_left = '<M-Left>',
        line_right = '<M-Right>',
        line_down = '<M-Down>',
        line_up = '<M-Up>',
      },
    }

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      local recording = _G.is_recording and ' ⏺ recording ' or ''
      return recording .. '%2l:%-2c'
    end
    vim.cmd 'highlight MiniStatuslineModeNormal guibg=Yellow guifg=Black'
  end,
}
