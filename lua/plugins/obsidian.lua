-- lua/plugins/obsidian.lua
return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = false,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'saghen/blink.cmp',
    'folke/snacks.nvim',
    -- 'nvim-telescope/telescope.nvim',
  },

  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = 'work',
        path = vim.fn.expand '~' .. '/.obsidian/work',
      },
    },

    daily_notes = {
      folder = 'daily-notes',
      -- Optional: Date format for note filenames. Defaults to "%Y-%m-%d".
      -- date_format = "%Y-%m-%d",
      -- Optional: Template file path relative to the vault root.
      -- template = "templates/daily.md",
    },

    -- How new notes are created. "current_dir", "notes_subdir", or "root"
    new_notes_location = 'notes_subdir',

    -- NEW: All checkbox settings are now in this table
    checkbox = {
      -- The order of checkbox symbols to cycle through when you press the toggle keymap.
      order = {
        ' ',
        'x',
        '>',
        '<',
        '?',
        '!',
        '*',
        '"',
        'i',
        '~',
      },
      -- The definitions for each checkbox symbol's appearance.
      symbols = {
        [' '] = { char = '󰄱', hl_group = 'Obsidian todo' }, -- todo
        ['x'] = { char = '', hl_group = 'Obsidian done' }, -- done
        ['>'] = { char = '', hl_group = 'Obsidian rightArrow' }, -- Delegated / Forwarded
        ['<'] = { char = '', hl_group = 'Obsidian leftArrow' }, -- Scheduled
        ['?'] = { char = '', hl_group = 'Obsidian question' }, -- Question
        ['!'] = { char = '', hl_group = 'Obsidian important' }, -- Important
        ['*'] = { char = '󰓎', hl_group = 'Obsidian star' }, -- Star
        ['"'] = { char = '󰍠', hl_group = 'Obsidian quote' }, -- Quote
        ['i'] = { char = '', hl_group = 'Obsidian info' }, -- Info / Idea
        ['~'] = { char = '󰰱', hl_group = 'Obsidian tilde' }, -- Obsolete / Canceled
      },
    },

    -- Integrate with nvim-cmp for completion
    completion = {
      nvim_cmp = false, -- Set to false if you don't use nvim-cmp
      min_chars = 2, -- Trigger completion after 2 characters
    },

    -- Optional UI enhancements
    ui = {
      enable = false, -- Set to true to use Telescope previews, etc.
      -- Set to true to conceal markdown formatting (e.g. hide '[[', ']]')
      conceal = true,
    },

    -- Other options...
    -- Templates, frontmatter manipulation, link following behavior, etc.
    -- see :help obsidian-options
  },

  -- Use the 'config' function to run setup code after the plugin loads
  config = function(_, opts)
    -- Setup the plugin with the defined options
    require('obsidian').setup(opts)

    -- Define keybindings in a structured list
    local maps = {
      -- Normal Mode Keybindings
      { mode = 'n', key = '<leader>oo', action = '<cmd>Obsidian open<CR>', desc = 'Open Obsidian Note (in vault)' },
      { mode = 'n', key = '<leader>ow', action = '<cmd>Obsidian workspace<CR>', desc = 'Switch Obsidian Workspace' },
      { mode = 'n', key = '<leader>on', action = '<cmd>Obsidian new<CR>', desc = 'Create New Note', opts = { silent = false } }, -- Renamed from 'onn' for consistency
      { mode = 'n', key = '<leader>oq', action = '<cmd>Obsidian quickSwitch<CR>', desc = 'Quick Switch Note' },
      { mode = 'n', key = '<leader>of', action = '<cmd>Obsidian followLink<CR>', desc = 'Follow Link under cursor' },
      { mode = 'n', key = '<leader>ob', action = '<cmd>Obsidian backlinks<CR>', desc = 'Show Backlinks' },
      { mode = 'n', key = '<leader>os', action = '<cmd>Obsidian search<CR>', desc = 'Search Notes' },
      { mode = 'n', key = '<leader>ott', action = '<cmd>Obsidian tags<CR>', desc = 'List Notes by Tag' }, -- Renamed from 'ott'
      { mode = 'n', key = '<leader>od', action = '<cmd>Obsidian today<CR>', desc = "Open Today's Daily Note" },

      { mode = 'n', key = '<leader>oy', action = '<cmd>Obsidian yesterday<CR>', desc = "Open Yesterday's Daily Note" },
      { mode = 'n', key = '<leader>otm', action = '<cmd>Obsidian tomorrow<CR>', desc = "Open Tomorrow's Daily Note" },
      { mode = 'n', key = '<leader>oa', action = '<cmd>Obsidian dailies<CR>', desc = 'List Daily Notes (Telescope)' },
      { mode = 'n', key = '<leader>op', action = '<cmd>Obsidian pasteImg<CR>', desc = 'Paste Image from Clipboard' },
      { mode = 'n', key = '<leader>or', action = '<cmd>Obsidian rename<CR>', desc = 'Rename Current Note', opts = { silent = false } },
      { mode = 'n', key = '<leader>oc', action = '<cmd>Obsidian toggleCheckbox<CR>', desc = 'Toggle Checkbox' },
      { mode = 'n', key = '<leader>otc', action = '<cmd>Obsidian toC<CR>', desc = 'Show Table of Contents' },
      { mode = 'n', key = '<leader>ol', action = '<cmd>Obsidian links<CR>', desc = 'List Links in Current Note' }, -- Changed the action for <leader>ol in Normal mode

      -- Visual Mode Keybindings
      { mode = 'v', key = '<leader>ol', action = '<cmd>Obsidian link<CR>', desc = 'Link Visual Selection to Note' }, -- Kept <leader>ol for visual link creation
      { mode = 'v', key = '<leader>onl', action = '<cmd>Obsidian linkNew<CR>', desc = 'Create New Note from Selection and Link' },
      { mode = 'v', key = '<leader>oe', action = '<cmd>Obsidian extractNote<CR>', desc = 'Extract Selection to New Note', opts = { silent = false } },
    }

    -- Apply the keybindings
    for _, map in ipairs(maps) do
      local options = { silent = true, desc = map.desc } -- Default options
      -- Merge custom opts if provided in the map definition
      if map.opts then
        options = vim.tbl_extend('force', options, map.opts)
      end
      vim.keymap.set(map.mode, map.key, map.action, options)
    end
  end,
}
