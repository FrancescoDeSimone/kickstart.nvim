local spec = {
  'nvim-mini/mini.nvim',
  config = function()
    require('mini.ai').setup {
      n_lines = 500,
      mappings = {
        around_next = '',
        inside_next = '',
      },
    }
    require('mini.surround').setup()
    require('mini.bracketed').setup()
    require('mini.trailspace').setup()
    require('mini.move').setup {
      mappings = {
        left = '<M-Left>',
        right = '<M-Right>',
        down = '<M-Down>',
        up = '<M-Up>',
        line_left = '<M-Left>',
        line_right = '<M-Right>',
        line_down = '<M-Down>',
        line_up = '<M-Up>',
      },
    }
    require('mini.align').setup()

    local MiniStatusline = require 'mini.statusline'

    local function section_lsp_names(args)
      if MiniStatusline.is_truncated(args.trunc_width) then
        return ''
      end
      local clients = vim.lsp.get_clients { bufnr = 0 }
      if #clients == 0 then
        return ''
      end
      local names = {}
      for _, client in ipairs(clients) do
        names[#names + 1] = client.name
      end
      local icon = MiniStatusline.config.use_icons and '󰰎 ' or 'LSP '
      return icon .. table.concat(names, ', ')
    end

    local function section_progress(args)
      if MiniStatusline.is_truncated(args.trunc_width) then
        return ''
      end
      local status = vim.ui.progress_status()
      if status == '' then
        return ''
      end
      local icon = MiniStatusline.config.use_icons and ' ' or 'Progress: '
      return icon .. status
    end

    local function section_recording()
      local reg = vim.fn.reg_recording()
      if reg == '' then
        return ''
      end
      return '⏺ @' .. reg
    end

    local function section_debug(args)
      if MiniStatusline.is_truncated(args.trunc_width) then
        return ''
      end
      if not package.loaded['debugmaster'] then
        return ''
      end
      local ok, dm = pcall(require, 'debugmaster.debug.mode')
      if ok and dm.is_active() then
        return '󰃤 DEBUG'
      end
      return ''
    end

    MiniStatusline.setup {
      use_icons = vim.g.have_nerd_font,
      content = {
        active = function()
          local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
          local git = MiniStatusline.section_git { trunc_width = 40 }
          local diff = MiniStatusline.section_diff { trunc_width = 75 }
          local diagnostics = MiniStatusline.section_diagnostics {
            trunc_width = 75,
            signs = { ERROR = ' ', WARN = ' ', INFO = ' ', HINT = '󰌵 ' },
          }
          local filename = MiniStatusline.section_filename { trunc_width = 140 }
          local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
          local location = '%l:%2v'
          local search = MiniStatusline.section_searchcount { trunc_width = 75 }
          local lsp = section_lsp_names { trunc_width = 75 }
          local progress = section_progress { trunc_width = 75 }
          local recording = section_recording()
          local debug = section_debug { trunc_width = 75 }

          return MiniStatusline.combine_groups {
            { hl = mode_hl, strings = { mode, debug } },
            { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics } },
            '%<',
            { hl = 'MiniStatuslineFilename', strings = { filename } },
            '%=',
            { hl = 'MiniStatuslineFileinfo', strings = { progress, lsp, fileinfo } },
            { hl = mode_hl, strings = { recording, search, location } },
          }
        end,
      },
    }
    local function set_mini_hl()
      vim.api.nvim_set_hl(0, 'MiniStatuslineModeNormal', { bg = 'Yellow', fg = 'Black' })
    end
    set_mini_hl()
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = vim.api.nvim_create_augroup('mini-statusline-hl', { clear = true }),
      callback = set_mini_hl,
    })
  end,
}


-- Shim added by opencode

local function gh(repo) return 'https://github.com/' .. repo end

local function process_spec(s)
  if not s then return end

  -- Init
  if type(s.init) == 'function' then
    s.init()
  end
  
  -- Add the main plugin
  local url = type(s[1]) == 'string' and gh(s[1]) or nil
  if url then
    local version = s.version
    if version == '*' then version = nil end
    if version then
      vim.pack.add { { src = url, version = version } }
    else
      vim.pack.add { url }
    end
  end

  -- Add dependencies
  if s.dependencies then
    for _, dep in ipairs(s.dependencies) do
      local dep_url = type(dep) == 'string' and gh(dep) or (type(dep) == 'table' and type(dep[1]) == 'string' and gh(dep[1]) or nil)
      if dep_url then
        vim.pack.add { dep_url }
      end
    end
  end

  -- Setup
  local module_name = s.main
  if not module_name and type(s[1]) == 'string' then
    module_name = s[1]:match(".*/(.*)"):gsub("%.nvim$", "")
  end

  if s.config == true or type(s.config) == 'nil' then
    if s.opts and module_name then
      local ok, mod = pcall(require, module_name)
      if ok and mod.setup then
        mod.setup(s.opts)
      end
    end
  elseif type(s.config) == 'function' then
    s.config()
  end

  -- Keys
  if s.keys then
    for _, key in ipairs(s.keys) do
      local mode = key.mode or 'n'
      local lhs = key[1]
      local rhs = key[2]
      if lhs and rhs then
        local opts = { desc = key.desc, remap = key.remap, silent = key.silent, expr = key.expr }
        vim.keymap.set(mode, lhs, rhs, opts)
      end
    end
  end
end

if spec[1] and type(spec[1]) == 'table' then
  for _, s in ipairs(spec) do
    process_spec(s)
  end
else
  process_spec(spec)
end
