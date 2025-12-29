return { -- Collection of various small independent plugins/modules
  'nvim-mini/mini.nvim',
  config = function()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.surround').setup()
    require('mini.bracketed').setup()
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
    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = vim.g.have_nerd_font }
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      local recording = _G.is_recording and ' ⏺ recording ' or ''
      return recording .. '%2l:%-2c'
    end
    vim.cmd 'highlight MiniStatuslineModeNormal guibg=Yellow guifg=Black'
  end,
}
