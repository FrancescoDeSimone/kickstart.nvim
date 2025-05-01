local globals = {
  colorizing_enabled = 1,
  disable_autoformat = false,
  disable_diagnostics = false,
  first_buffer_opened = false,
  have_nerd_font = true,
  loaded_perl_provider = 0,
  loaded_python_provider = 0,
  loaded_ruby_provider = 0,
  mapleader = ' ',
  maplocalleader = ' ',
  rustaceanvim = {
    dap = { autoloadConfigurations = true },
    server = {
      default_settings = {
        ['rust-analyzer'] = {
          cargo = { buildScripts = { enable = true }, features = 'all' },
          check = { command = 'clippy', features = 'all' },
          checkOnSave = true,
          completion = { fullFunctionSignatures = { enable = true } },
          diagnostics = { enable = true, styleLints = { enable = true } },
          files = { excludeDirs = { '.cargo', '.direnv', '.git', 'node_modules', 'target' } },
          inlayHints = {
            bindingModeHints = { enable = true },
            closureReturnTypeHints = { enable = 'always' },
            closureStyle = 'rust_analyzer',
            discriminantHints = { enable = 'always' },
            expressionAdjustmentHints = { enable = 'always' },
            implicitDrops = { enable = true },
            lifetimeElisionHints = { enable = 'always' },
            rangeExclusiveHints = { enable = true },
          },
          procMacro = { enable = true },
          rust = { analyzerTargetDir = true },
          rustc = { source = 'discover' },
        },
      },
    },
  },
  spell_enabled = true,
  vimtex_callback_progpath = 'nvim',
  vimtex_enabled = true,
  vimtex_view_method = 'zathura',
}

for k, v in pairs(globals) do
  vim.g[k] = v
end
