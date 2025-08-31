return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  opts = {
    cmdline = {
      enabled = true,
      view = 'cmdline_popup',
      format = {
        cmdline = { icon = '', lang = 'vim', pattern = '^:' },
        search_down = { icon = ' ', kind = 'search', lang = 'regex', pattern = '^/' },
        search_up = { icon = ' ', kind = 'search', lang = 'regex', pattern = '?%?' },
        filter = { icon = '$', lang = 'bash', pattern = '^:%s*!' },
        lua = { icon = '', lang = 'lua', pattern = '^:%s*lua%s+' },
        help = { icon = '', pattern = '^:%s*he?l?p?%s+' },
      },
    },

    lsp = {
      enabled = true,
      progress = {
        enabled = true,
        format = 'lsp_progress',
        formatDone = 'lsp_progress',
        view = 'mini',
      },
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
      hover = { enabled = true },
      signature = {
        enabled = true,
        autoOpen = { enabled = true, luasnip = true, throttle = 50, trigger = true },
      },
      message = {
        enabled = true,
        view = 'notify',
      },
      documentation = {
        view = 'hover',
        opts = {
          lang = 'markdown',
          replace = true,
          render = 'plain',
          format = { '{message}' },
          win_options = { concealcursor = 'n', conceallevel = 3, winhighlight = { FloatBorder = 'FloatBorder', Normal = 'NormalFloat' } },
        },
      },
    },

    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = false,
    },

    messages = {
      enabled = true,
      view = 'notify',
      view_warn = 'notify',
      view_error = 'notify',
      view_history = 'messages',
      view_search = 'virtualtext',
    },

    popupmenu = {
      enabled = true,
      backend = 'nui',
    },
    redirect = {
      view = 'split',
      filter = { event = 'msg_show' },
    },
    routes = {
      {
        filter = { event = 'msg_show', min_height = 20 },
        view = 'split',
      },
    },
    smartMove = {
      enabled = true,
      excludedFiletypes = { 'cmp_menu', 'cmp_docs', 'notify' },
    },
    health = { checker = true },
  },
}
