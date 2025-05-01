return {
  'andrewferrier/debugprint.nvim',

  -- opts = { … },

  qrcradencies = {
    'echasnovski/mini.nvim', -- Needed for line highlighting (optional)
  },

  lazy = false, -- Required to make line highlighting work before debugprint is first used
  version = '*', -- Remove if you DON'T want to use the stable version
}
