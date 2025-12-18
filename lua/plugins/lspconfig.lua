return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically installs LSPs and related tools.
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Completion and snippets
    'saghen/blink.cmp',
    'L3MON4D3/LuaSnip',

    -- A visualizer for LSP progress
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    -- This section ensures Mason is set up first before other plugins use it.
    require('mason').setup()

    -- This section configures and installs LSP servers.
    local servers = {
      clangd = {},
      gopls = {},
      ty = {},
      -- pyright = {},
      lua_ls = {
        settings = {
          Lua = {
            completion = { callSnippet = 'Replace' },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = {},
          },
        },
      },
    }

    -- This section configures and installs other standalone tools (formatters, etc.).
    local tools = {
      'stylua', -- Used to format Lua code
      'gofumpt', -- A more opinionated Go formatter
      'markdownlint',
      'hadolint',
      'jsonlint',
      'tflint',
      'vale',
      'black',
      'prettierd',
      'shellcheck',
      'shfmt',
      -- 'rustfmt',
    }

    require('mason-tool-installer').setup {
      ensure_installed = tools,
    }

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    local on_attach = function(client, bufnr)
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
      end

      -- Keymaps
      map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
      map('gra', vim.lsp.buf.code_action, 'Code [A]ction', { 'n', 'x' })
      map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
      map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      map('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
      map('gt', vim.lsp.buf.type_definition, '[G]oto [T]ype Definition')
      map('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
      -- map('<leader>f', vim.lsp.buf.format, 'Format Code')
      map('K', vim.lsp.buf.hover, 'Hover Documentation')
      map('<C-k>', vim.lsp.buf.signature_help, 'Signature Help')
      map('<leader>xl', vim.diagnostic.open_float, 'Show line diagnostics')

      -- Inlay hints
      if client.supports_method 'textDocument/inlayHint' then
        map('<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
        end, '[T]oggle Inlay [H]ints')
      end

      -- Auto-highlighting
      if client.supports_method 'textDocument/documentHighlight' then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = bufnr,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = bufnr,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })
        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = bufnr }
          end,
        })
      end
    end

    -- Diagnostic Config
    vim.diagnostic.config {
      severity_sort = true,
      float = { border = 'rounded', source = 'if_many' },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
      } or {},
      virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
          local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            [vim.diagnostic.severity.WARN] = diagnostic.message,
            [vim.diagnostic.severity.INFO] = diagnostic.message,
            [vim.diagnostic.severity.HINT] = diagnostic.message,
          }
          return diagnostic_message[diagnostic.severity]
        end,
      },
    }

    -- Set up lspconfig with mason-lspconfig
    require('mason-lspconfig').setup {
      ensure_installed = vim.tbl_keys(servers),
      automatic_installation = true,
      handlers = {
        -- This handler applies to all servers.
        function(server_name)
          local server_opts = servers[server_name] or {}
          server_opts.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server_opts.capabilities or {})
          server_opts.on_attach = on_attach
          require('lspconfig')[server_name].setup(server_opts)
        end,
      },
    }
  end,
}
