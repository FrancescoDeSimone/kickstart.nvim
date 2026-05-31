local M = {}

local function gh(repo)
  return 'https://github.com/' .. repo
end

function M.process_spec(s)
  if not s then return end

  -- 1. Run init() function if present
  if type(s.init) == 'function' then
    s.init()
  end
  
  -- 2. Add the main plugin
  local url = type(s[1]) == 'string' and gh(s[1]) or nil
  if url then
    local version = s.version
    if type(version) == 'string' then
      if version == '*' then
        version = nil
      else
        version = vim.version.range(version)
      end
    end
    
    -- Support branch/tag/commit aliases
    if s.branch then version = s.branch end
    if s.tag then version = s.tag end
    if s.commit then version = s.commit end

    if version then
      vim.pack.add { { src = url, version = version } }
    else
      vim.pack.add { url }
    end
  end

  -- 3. Add dependencies
  if s.dependencies then
    for _, dep in ipairs(s.dependencies) do
      local dep_url = type(dep) == 'string' and gh(dep) or (type(dep) == 'table' and type(dep[1]) == 'string' and gh(dep[1]) or nil)
      if dep_url then
        vim.pack.add { dep_url }
      end
    end
  end

  -- 4. Setup / Config
  local module_name = s.main
  if not module_name and type(s[1]) == 'string' then
    -- Guess the module name from the github repo name (e.g. 'stevearc/conform.nvim' -> 'conform')
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

  -- 5. Keymaps
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

function M.load_all()
  local plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'plugins')
  for file_name, type_ in vim.fs.dir(plugins_dir) do
    if type_ == 'file' and file_name:match '%.lua$' then
      local module = file_name:gsub('%.lua$', '')
      local ok, spec = pcall(require, 'plugins.' .. module)
      if ok and spec then
        if spec[1] and type(spec[1]) == 'table' then
          for _, s in ipairs(spec) do
            M.process_spec(s)
          end
        else
          M.process_spec(spec)
        end
      end
    end
  end
end

return M
