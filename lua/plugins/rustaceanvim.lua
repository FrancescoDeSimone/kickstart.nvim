return {
  'mrcjkb/rustaceanvim',
  version = '^5', -- Update to latest version
  lazy = false,
  init = function()
    -- Move the config from globals.lua to here
    vim.g.rustaceanvim = {
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
    }
  end,
}
