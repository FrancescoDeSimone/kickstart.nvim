return {
  'kawre/leetcode.nvim',
  build = ':TSUpdate html', -- if you have `nvim-treesitter` installed
  dependencies = {
    -- telescope removed — using snacks picker instead
    'MunifTanjim/nui.nvim',
  },
  opts = {
    picker = { provider = 'snacks' },
  },
}
