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
        json = { 'jsonlint' },
        rst = { 'vale' },
        terraform = { 'tflint' },
        text = { 'vale' },
        sh = { 'shellcheck' },
        bash = { 'shellcheck' },
        nix = { 'statix' },
      }
    end,
  },
}
