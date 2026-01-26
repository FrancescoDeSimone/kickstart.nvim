return {
  'Dan7h3x/signup.nvim',
  branch = 'main',
  opts = {
    silent = true,
    icons = {
      parameter = '',
      method = '󰡱',
      documentation = '󱪙',
      type = '󰌗',
      default = '󰁔',
    },
    colors = {
      parameter = '#e4e4e4',
      method = '#96a6c8',
      documentation = '#ccac93',
      type = '#ffdd33',
      default_value = '#9e95c7',
    },
    active_parameter = true, -- enable/disable active_parameter highlighting
    active_parameter_colors = {
      bg = '#ffdd33',
      fg = '#181818',
    },
    border = 'rounded',
    dock_border = 'rounded',
    winblend = 0,
    auto_close = true,
    trigger_chars = { '(', ',', ')' },
    max_height = 12,
    max_width = 65,
    floating_window_above_cur_line = true,
    debounce_time = 50,
    dock_toggle_key = '<Leader>sd',
    dock_mode = {
      enabled = true,
      position = 'top', -- "bottom", "top", or "middle"
      height = 4, -- If > 1: fixed height in lines, if <= 1: percentage of window height (e.g., 0.3 = 30%)
      padding = 1, -- Padding from window edges
      side = 'right', -- "right", "left", or "center"
      width_percentage = 40, -- Percentage of editor width (10-90%)
    },
  },
  config = function(_, opts)
    -- https://github.com/Dan7h3x/signup.nvim/issues/10
    local ok, cmp = pcall(require, 'cmp')
    if ok and not cmp.visible then
      cmp.visible = function()
        local blink_ok, blink = pcall(require, 'blink-cmp')
        return blink_ok and blink.is_visible()
      end
    end
    require('signup').setup(opts)
  end,
}
