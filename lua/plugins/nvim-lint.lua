local spec = {

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
        callback = function(args)
          if vim.b[args.buf].disable_lint then
            return
          end
          lint.try_lint(nil, { buf = args.buf })
        end,
      })
    end,
  },
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
      vim.pack.add { src = url, version = version }
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
