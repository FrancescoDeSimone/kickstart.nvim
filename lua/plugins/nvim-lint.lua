return {

  { -- Linting (manual via <leader>rl)
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      {
        '<leader>rl',
        function()
          require('lint').try_lint()
        end,
        desc = '[L]int buffer',
      },
    },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        dockerfile = { 'hadolint' },
        terraform = { 'tflint' },
        sh = { 'shellcheck' },
        bash = { 'shellcheck' },
        nix = { 'deadnix', 'statix' },
      }

      local statix_cmd = vim.fn.exepath 'statix'
      if statix_cmd ~= '' then
        lint.linters.statix = vim.tbl_deep_extend('force', lint.linters.statix or {}, {
          cmd = statix_cmd,
        })
      end

      local deadnix_cmd = vim.fn.exepath 'deadnix'
      if deadnix_cmd ~= '' then
        lint.linters.deadnix = vim.tbl_deep_extend('force', lint.linters.deadnix or {}, {
          cmd = deadnix_cmd,
        })
      end
      vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave' }, {
        group = vim.api.nvim_create_augroup('nvim-lint-auto', { clear = true }),
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
