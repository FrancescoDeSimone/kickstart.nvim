vim.keymap.set('n', '<leader>-', function()
  vim.cmd 'vsplit | wincmd l'
  require('oil').open()
end)
vim.keymap.set('n', '-', '<CMD>:lua require("oil").open(nil,{ preview = { vertical = true } })<CR>', { desc = 'Open parent directory' })
return {
  {
    {
      'stevearc/oil.nvim',
      ---@module 'oil'
      ---@type oil.SetupOpts
      opts = {
        columns = { 'type', { 'icon', default_file = 'bar', directory = 'dir', highlight = 'Foo' }, 'size', 'permissions' },
        experimental_watch_for_changes = true,
        keymaps = { ['<C-r>'] = 'actions.refresh', ['q'] = 'actions.close', ['y.'] = 'actions.copy_entry_path' },
        skip_confirm_for_simple_edits = true,
        default_file_explorer = true,
        view_options = { show_hidden = true },
        win_options = {
          concealcursor = 'ncv',
          conceallevel = 3,
          cursorcolumn = false,
          foldcolumn = '0',
          list = false,
          signcolumn = 'yes',
          spell = false,
          winbar = "%{v:lua.require('oil').get_current_dir()}",
          wrap = false,
        },
      },
      -- Optional dependencies
      dependencies = { { 'echasnovski/mini.icons', opts = {} } },
      -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
      -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
      lazy = false,
    },
  },
}
