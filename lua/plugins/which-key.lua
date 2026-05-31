local spec = {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    preset = 'modern',
    delay = 0,
    icons = {
      mappings = true,
      group = ' ',
      separator = ' ',
      colors = true,
    },
    spec = {
      { '<leader>p', group = '[P]rogramming', icon = { icon = ' ', color = 'orange' } },
      { '<leader>pr', group = '[R]un / Rename', icon = { icon = ' ', color = 'blue' } },
      { '<leader>pv', group = '[V]env / Packages', icon = { icon = ' ', color = 'green' } },
      { '<leader>c', group = '[C]++ Reference', icon = { icon = '󰙲 ', color = 'blue' } },
      { '<leader>D', group = '[D]ebug', icon = { icon = '󰃤 ', color = 'red' } },
      { '<leader>f', group = '[F]olds', icon = { icon = ' ', color = 'yellow' } },
      { '<leader>g', group = '[G]it', icon = { icon = ' ', color = 'orange' } },
      { '<leader>gh', group = 'Git [H]unks', icon = { icon = '󰊢 ', color = 'orange' } },
      { '<leader>o', group = '[O]penCode', icon = { icon = ' ', color = 'purple' } },
      { '<leader>r', group = '[R]eplace/Refactor', icon = { icon = ' ', color = 'cyan' } },
      { '<leader>s', group = '[S]earch', icon = { icon = ' ', color = 'green' } },
      { '<leader>S', group = '[S]ession', icon = { icon = ' ', color = 'azure' } },
      { '<leader>t', group = '[T]ools', icon = { icon = ' ', color = 'purple' } },
      { '<leader>u', group = '[U]I', icon = { icon = '󰙵 ', color = 'cyan' } },
      { '<leader>x', group = '[X] Diagnostics', icon = { icon = '󱖫 ', color = 'green' } },
      { '<leader>.', group = 'Scratch', icon = { icon = '󰏫 ', color = 'yellow' } },
      { '<leader>e', desc = 'File Explorer', icon = { icon = '󰙅 ', color = 'cyan' } },
      { '<leader>-', desc = 'File Explorer (Oil)', icon = { icon = '󰙅 ', color = 'cyan' } },
      { '<leader>b', desc = 'Buffers', icon = { icon = '󰈔 ', color = 'cyan' } },
      { '<leader>q', desc = 'Delete Buffer', icon = { icon = '󰅖 ', color = 'red' } },
      { '<leader>z', desc = 'Toggle Zoom', icon = { icon = '󰁌 ', color = 'blue' } },
      { '<leader>Z', desc = 'Toggle Zen Mode', icon = { icon = '󱅻 ', color = 'cyan' } },
      { '<leader>N', desc = 'Neovim News', icon = { icon = '󰎕 ', color = 'green' } },
      { '<leader>y', desc = 'Registers', icon = { icon = '󱓥 ', color = 'yellow' } },
      { '<leader>/', desc = 'Buffer Lines', icon = { icon = ' ', color = 'green' } },
      { '<leader>:', desc = 'Command History', icon = { icon = ' ', color = 'purple' } },
      { '<leader>n', desc = 'Notification History', icon = { icon = '󰵅 ', color = 'blue' } },
      { '<leader><leader>', desc = 'Peep', icon = { icon = '󰈈 ', color = 'yellow' } },

      -- Nvim 0.12 default LSP keymaps (documented here for discoverability)
      { 'grn', desc = 'LSP Rename' },
      { 'gra', desc = 'LSP Code Action', mode = { 'n', 'v' } },
      { 'grr', desc = 'LSP References' },
      { 'gri', desc = 'LSP Implementation' },
      { 'grt', desc = 'LSP Type Definition' },
      { 'grx', desc = 'LSP Run Codelens' },
      { 'gO',  desc = 'LSP Document Symbols' },
      { 'gx',  desc = 'Open link / LSP documentLink' },
    },
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
      vim.pack.add { { src = url, version = version } }
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
