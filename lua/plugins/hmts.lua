return {
  'calops/hmts.nvim',
  version = '*',
  opts = {},
  build = function(plugin)
    local path = plugin.dir .. '/plugin/hmts.lua'
    local file = io.open(path, 'r')
    if not file then
      vim.notify('hmts.nvim: could not open ' .. path, vim.log.levels.WARN)
      return
    end
    local content = file:read '*a'
    file:close()

    local patched = content
      -- Fix hmts_path_handler: unwrap TSNode[] before calling :parent()
      :gsub(
        '\tlocal node = match%[predicate%[2%]%]:parent%(%)',
        '\tlocal _m1 = match[predicate[2]]\n'
          .. '\tif type(_m1) == "table" then _m1 = _m1[1] end\n'
          .. '\tlocal node = _m1 and _m1:parent() or nil'
      )
      -- Fix hmts_inject_handler: unwrap TSNode[] before passing to get_node_text
      :gsub(
        '(\tlocal path_node = match%[predicate%[2%]%])\n',
        '%1\n\tif type(path_node) == "table" then path_node = path_node[1] end\n'
      )

    if patched == content then
      vim.notify('hmts.nvim: patch already applied', vim.log.levels.INFO)
      return
    end

    file = io.open(path, 'w')
    if not file then
      vim.notify('hmts.nvim: could not write ' .. path, vim.log.levels.WARN)
      return
    end
    file:write(patched)
    file:close()
    vim.notify('hmts.nvim: Neovim 0.12 compatibility patch applied', vim.log.levels.INFO)
  end,
}
