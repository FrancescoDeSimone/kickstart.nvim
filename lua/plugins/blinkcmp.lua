local spec = {
  {
    'saghen/blink.compat',
    version = '*',
    lazy = true,
    opts = {},
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'ray-x/cmp-sql',
    },

    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'super-tab',
        ['<CR>'] = { 'accept', 'fallback' },
      },

      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = { documentation = { auto_show = false } },
      signature = { enabled = true },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'sql' },
        providers = {
          sql = {
            name = 'sql',
            module = 'blink.compat.source',
            score_offset = -3,
            opts = {},
            should_show_items = function()
              return vim.tbl_contains(
                { 'sql' },
                vim.o.filetype
              )
            end,
          },
        },
      },
      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = 'prefer_rust' },
    },
    opts_extend = { 'sources.default' },
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
