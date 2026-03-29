vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

local diag_group = vim.api.nvim_create_augroup('kickstart-disable-diagnostic', { clear = true })

vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  group = diag_group,
  callback = function()
    vim.diagnostic.show(nil, vim.api.nvim_get_current_buf())
  end,
})

vim.api.nvim_create_autocmd('InsertEnter', {
  pattern = '*',
  group = diag_group,
  callback = function()
    vim.diagnostic.hide(nil, vim.api.nvim_get_current_buf())
  end,
})

local misc_group = vim.api.nvim_create_augroup('kickstart-misc', { clear = true })

vim.api.nvim_create_autocmd('VimResized', {
  pattern = '*',
  group = misc_group,
  command = 'wincmd =',
})
