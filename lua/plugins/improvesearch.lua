local spec = {
  'backdround/improved-search.nvim',
  event = 'VeryLazy',
  config = function()
    local search = require 'improved-search'
    -- Search next / previous.
    vim.keymap.set({ 'n', 'x', 'o' }, 'n', search.stable_next)
    vim.keymap.set({ 'n', 'x', 'o' }, 'N', search.stable_previous)

    -- Search current word without moving.
    vim.keymap.set('n', '!', search.current_word)

    -- Search selected text in visual mode
    vim.keymap.set('x', '!', search.in_place) -- search selection without moving
    vim.keymap.set('x', '*', search.forward) -- search selection forward
    vim.keymap.set('x', '#', search.backward) -- search selection backward

    -- Search by motion in place
    vim.keymap.set('n', '|', search.in_place)
    -- You can also use search.forward / search.backward for motion selection.
  end,
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
