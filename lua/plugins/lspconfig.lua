return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Mason: installs LSPs and related tools.
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Completion (blink.cmp handles snippets via vim.snippet + friendly-snippets)
    'saghen/blink.cmp',

    -- NOTE: fidget.nvim removed — Nvim 0.12 has native TUI progress bars
    -- and default statusline integration via vim.ui.progress_status().
  },
  config = function()
    -- This section ensures Mason is set up first before other plugins use it.
    require('mason').setup()

    -- LSP server configurations.
    -- These are merged with nvim-lspconfig's defaults via vim.lsp.config().
    local servers = {
      clangd = {},
      cssls = {},
      gopls = {},
      html = {},
      ty = {}, -- fast Python type checking
      ruff = {}, -- fast Python lint/format
      -- vtsls: fast TypeScript/JavaScript language server.
      vtsls = {},
      bashls = {},
      zls = {},
      nil_ls = {},
      terraformls = {},
      marksman = {},
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

    -- Standalone tools (formatters, linters, etc.) installed via Mason.
    local tools = {
      'stylua',
      'gofumpt',
      'hadolint',
      'tflint',
      'prettierd',
      'shellcheck',
      'shfmt',
      'markdownlint',
      'clang-format',
      'alejandra',
      'ruff',
    }

    require('mason-tool-installer').setup {
      ensure_installed = tools,
    }

    -- Ensure Mason installs the LSP servers we need.
    require('mason-lspconfig').setup {
      ensure_installed = vim.tbl_keys(servers),
      automatic_installation = true,
      -- Disable automatic_enable since we manually call vim.lsp.enable() below.
      -- Without this, mason-lspconfig auto-enables ALL installed Mason packages
      -- that have an lspconfig mapping (e.g. stylua, tflint as LSP servers).
      automatic_enable = false,
    }

    -- Nvim 0.12: Use vim.lsp.config() + vim.lsp.enable() instead of
    -- the old mason-lspconfig handler + lspconfig[server].setup() pattern.
    --
    -- Global defaults for all servers:
    vim.lsp.config('*', {
      root_markers = { '.git' },
    })

    -- Per-server overrides (call for all servers, even empty opts,
    -- so blink.cmp capabilities and wildcard config are properly merged):
    for server_name, server_opts in pairs(servers) do
      vim.lsp.config(server_name, server_opts)
    end

    -- Activate all configured servers. Nvim 0.12 will auto-attach them
    -- to matching buffers based on filetypes and root_markers.
    vim.lsp.enable(vim.tbl_keys(servers))

    -- Nvim 0.12: Enable new builtin LSP features
    vim.lsp.codelens.enable(true)
    vim.lsp.document_color.enable(true, nil, { style = 'virtual' })
    vim.lsp.linked_editing_range.enable()
    -- NOTE: on_type_formatting disabled — it conflicts with snippet expansion.
    -- When expanding multi-line snippets (e.g. 'main' in C), clangd's on-type
    -- formatting triggers on '\n' characters and applies text edits that corrupt
    -- the snippet's tabstops and surrounding text.
    -- vim.lsp.on_type_formatting.enable()

    -- LspAttach: buffer-local keymaps and features.
    -- NOTE: Nvim 0.12 sets these keymaps globally by default:
    --   grn  = vim.lsp.buf.rename()
    --   gra  = vim.lsp.buf.code_action()
    --   grr  = vim.lsp.buf.references()
    --   gri  = vim.lsp.buf.implementation()
    --   grt  = vim.lsp.buf.type_definition()
    --   grx  = vim.lsp.codelens.run()
    --   gO   = vim.lsp.buf.document_symbol()
    --   K    = vim.lsp.buf.hover() (buffer-local, on attach)
    --   <C-S>= vim.lsp.buf.signature_help() (insert mode)
    --
    -- We only add keymaps that aren't defaults.
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local bufnr = event.buf
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then
          return
        end

        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
        end

        -- Non-default keymaps only:
        -- LSP navigation handled by snacks picker: gd, gD, gI, gy, gr (see snacks.lua)
        map('<C-k>', vim.lsp.buf.signature_help, 'Signature Help')
        map('<leader>xl', vim.diagnostic.open_float, 'Show line diagnostics')
        map('<leader>xW', vim.lsp.buf.workspace_diagnostics, 'LSP Workspace Diagnostics')

        -- Inlay hints toggle
        if client:supports_method 'textDocument/inlayHint' then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
          end, '[T]oggle Inlay [H]ints')
        end

        -- Auto-highlighting: highlight references under cursor
        if client:supports_method 'textDocument/documentHighlight' then
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
      end,
    })

    -- Diagnostic Config
    vim.diagnostic.config {
      severity_sort = true,
      float = { border = 'rounded', source = true },
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
        source = true,
        spacing = 2,
      },
      -- Nvim 0.12: diagnostic status for statusline integration
      status = vim.g.have_nerd_font and {
        format = {
          [vim.diagnostic.severity.ERROR] = '󰅚',
          [vim.diagnostic.severity.WARN] = '󰀪',
          [vim.diagnostic.severity.INFO] = '󰋽',
          [vim.diagnostic.severity.HINT] = '󰌶',
        },
      } or {},
    }
  end,
}
