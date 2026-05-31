-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
vim.loader.enable()

require 'globals'
require 'options'
require 'keymap'
require 'autocommand'

local function run_build(name, cmd, cwd)
  local result = vim.system(cmd, { cwd = cwd }):wait()
  if result.code ~= 0 then
    local stderr = result.stderr or ''
    local stdout = result.stdout or ''
    local output = stderr ~= '' and stderr or stdout
    if output == '' then
      output = 'No output from build command.'
    end
    vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
  end
end

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then
      return
    end

    if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
      run_build(name, { 'make' }, ev.data.path)
      return
    end

    if name == 'LuaSnip' then
      if vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then
        run_build(name, { 'make', 'install_jsregexp' }, ev.data.path)
      end
      return
    end

    if name == 'nvim-treesitter' then
      if not ev.data.active then
        vim.cmd.packadd 'nvim-treesitter'
      end
      vim.cmd 'TSUpdate'
      return
    end

    if name == 'snacks.nvim' then
      if not ev.data.active then
        vim.cmd.packadd 'snacks.nvim'
      end
      return
    end
  end,
})

require('pack_loader').load_all()

vim.cmd.packadd 'nvim.undotree' -- :Undotree  — visual undo-tree navigation
vim.cmd.packadd 'nvim.tohtml' --  :TOhtml    — export buffer to HTML
vim.cmd.packadd 'nvim.difftool' -- :DiffTool  — compare two files/directories

-- Use g< or ENTER to open the pager.
require('vim._core.ui2').enable {
  msg = {
    targets = {
      emsg = 'msg',
      wmsg = 'msg',
      lua_error = 'msg',
      echoerr = 'msg',
    },
    msg = {
      timeout = 4000,
    },
    pager = {
      height = 1,
    },
  },
}
