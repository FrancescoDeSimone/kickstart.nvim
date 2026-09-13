return { -- Formatting (manual via <leader>rf)
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>rf',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 500, lsp_format = 'fallback' }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      c = { 'clang_format' },
      cpp = { 'clang_format' },
      javascript = { 'oxfmt' },
      typescript = { 'oxfmt' },
      typescriptreact = { 'oxfmt' },
      javascriptreact = { 'oxfmt' },
      css = { 'oxfmt' },
      json = { 'oxfmt' },
      python = { 'ruff_format' },
      html = { 'prettierd', 'prettier', stop_after_first = true },
      markdown = { 'prettierd', 'prettier', stop_after_first = true },
      bash = { 'shfmt' },
      sh = { 'shfmt' },
      -- rust = { 'rustfmt' }, -- handled by rustaceanvim LSP formatting
      nix = { 'alejandra' },
      terraform = { 'terraform_fmt' },
      go = { 'gofumpt' },
      zig = { 'zigfmt' },
    },
    default_format_opts = {
      lsp_format = 'fallback',
    },
    formatters = {
      shfmt = {
        prepend_args = { '-i', '2' },
      },
    },
  },
}
