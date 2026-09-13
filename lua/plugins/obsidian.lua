return {
  'epwalsh/obsidian.nvim',
  version = '*',
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    workspaces = {
      {
        name = 'work',
        path = '/home/fdesi/.obsidian/work',
      },
      {
        name = 'personal',
        path = '/home/fdesi/.obsidian',
      },
    },
    completion = {
      nvim_cmp = false,
      blink = true,
      min_chars = 2,
    },
    daily_notes = {
      folder = 'daily-notes',
      date_format = '%Y-%m-%d',
      alias_format = '%B %-d, %Y',
      default_tags = { 'daily-notes' },
      template = nil,
    },
    notes_subdir = 'sunbeam-notes',
    new_notes_location = 'notes_subdir',
    prefer_id_links = true,
    id_digits = 8,
    open_note_commands = {
      'ObsidianFollowLink',
      'ObsidianOpen',
      'ObsidianSearch',
      'ObsidianQuickSwitch',
    },
    disable_frontmatter = false,
    follow_url_func = function(url)
      vim.fn.jobstart { 'xdg-open', url }
    end,
    use_advanced_ui = false,
    ui = {
      enable = false,
    },
    mappings = {},
    note_id_func = function(title)
      local suffix = ''
      if title ~= nil then
        suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      else
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return suffix
    end,
    note_frontmatter_func = function(note)
      if note.title then
        note.tags = note.tags or {}
        if vim.tbl_contains({ 'daily-notes' }, vim.split(note.id, '-')[1]) then
          note.tags[#note.tags + 1] = 'daily-notes'
        end
      end
      return {
        id = note.id,
        title = note.title,
        aliases = note.aliases,
        tags = note.tags,
        area = note.area,
      }
    end,
    templates = {
      folder = 'templates',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M',
    },
    sort = {
      enabled = true,
    },
    tag_nav = {
      enabled = true,
    },
    commands = {},
  },
  keys = {
    { '<leader>on', '<cmd>ObsidianNew<CR>', desc = 'New Obsidian note' },
    { '<leader>os', '<cmd>ObsidianSearch<CR>', desc = 'Search Obsidian notes' },
    { '<leader>oo', '<cmd>ObsidianOpen<CR>', desc = 'Open note in Obsidian app' },
    { '<leader>od', '<cmd>ObsidianToday<CR>', desc = 'Open today daily note' },
    { '<leader>oy', '<cmd>ObsidianYesterday<CR>', desc = 'Open yesterday daily note' },
    { '<leader>ot', '<cmd>ObsidianTomorrow<CR>', desc = 'Open tomorrow daily note' },
    { '<leader>ol', '<cmd>ObsidianFollowLink<CR>', desc = 'Follow Obsidian [[link]]' },
    { '<leader>ob', '<cmd>ObsidianBacklinks<CR>', desc = 'Show backlinks' },
    {
      '<leader>oB',
      function()
        require('obsidian').util.toggle_checkbox()
      end,
      mode = { 'n', 'v' },
      desc = 'Toggle Obsidian checkbox',
    },
    {
      '<leader>ox',
      function()
        require('obsidian').util.toggle_checkbox()
      end,
      mode = { 'n', 'v' },
      desc = 'Toggle Obsidian checkbox',
    },
  },
}
