return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    cmdline = {
      enabled = true,
      format = {
        cmdline = { icon = '', lang = 'vim', pattern = '^:' },
        filter = { icon = '$', lang = 'bash', pattern = '^:%s*!' },
        help = { icon = '', pattern = '^:%s*he?l?p?%s+' },
        lua = { icon = '', lang = 'lua', pattern = '^:%s*lua%s+' },
        search_down = { icon = ' ', kind = 'search', lang = 'regex', pattern = '^/' },
        search_up = { icon = ' ', kind = 'search', lang = 'regex', pattern = '?%?' },
      },
      view = 'cmdline_popup',
    },
    commands = {
      errors = { filter = { error = true }, filter_opts = { reverse = true }, opts = { enter = true, format = 'details' }, view = 'split' },
      history = {
        filter = {
          any = { { event = 'notify' }, { error = true }, { warning = true }, { event = 'msg_show', kind = { '' } }, { event = 'lsp', kind = 'message' } },
        },
        opts = { enter = true, format = 'details' },
        view = 'split',
      },
      last = {
        filter = {
          any = { { event = 'notify' }, { error = true }, { warning = true }, { event = 'msg_show', kind = { '' } }, { event = 'lsp', kind = 'message' } },
        },
        filter_opts = { count = 1 },
        opts = { enter = true, format = 'details' },
        view = 'popup',
      },
    },
    health = { checker = true },
    lsp = {
      documentation = {
        opts = {
          format = { '{message}' },
          lang = 'markdown',
          render = 'plain',
          replace = true,
          win_options = { concealcursor = 'n', conceallevel = 3, winhighlight = { FloatBorder = 'FloatBorder', Normal = 'NormalFloat' } },
        },
        view = 'hover',
      },
      hover = { enabled = true },
      message = { enabled = true, view = 'notify' },
      override = { ['cmp.entry.get_documentation'] = true, ['vim.lsp.util.convert_input_to_markdown_lines'] = true, ['vim.lsp.util.stylize_markdown'] = true },
      progress = { enabled = true, format = 'lsp_progress', formatDone = 'lsp_progress', view = 'mini' },
      signature = { autoOpen = { enabled = true, luasnip = true, throttle = 50, trigger = true }, enabled = true },
    },
    markdown = {
      highlights = {
        ['@%S+'] = '@parameter',
        ['^%s*(Parameters:)'] = '@text.title',
        ['^%s*(Return:)'] = '@text.title',
        ['^%s*(See also:)'] = '@text.title',
        ['{%S-}'] = '@parameter',
        ['|%S-|'] = '@text.reference',
      },
      hover = { ['%[.-%]%((%S-)%)'] = require('noice.util').open, ['|(%S-)|'] = vim.cmd.help },
    },
    messages = { enabled = true, view = 'notify', view_error = 'notify', view_history = 'messages', view_search = 'virtualtext', view_warn = 'notify' },
    notify = { enabled = true, view = 'notify' },
    popupmenu = { backend = 'nui', enabled = true, kindIcons = true },
    presets = { bottom_search = true, command_palette = true, inc_rename = false, long_message_to_split = true, lsp_doc_border = false },
    redirect = { filter = { event = 'msg_show' }, view = 'split' },
    routes = { { filter = { event = 'msg_show', min_height = 20 }, view = 'split' } },
    smartMove = { enabled = true, excludedFiletypes = { 'cmp_menu', 'cmp_docs', 'notify' } },
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    -- 'rcarriga/nvim-notify',
  },
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
}
