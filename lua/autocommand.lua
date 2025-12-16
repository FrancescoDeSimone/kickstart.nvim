vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  group = vim.api.nvim_create_augroup('disable diagnostic', { clear = true }),
  callback = function()
    vim.diagnostic.show()
  end,
})

vim.api.nvim_create_autocmd('InsertEnter', {
  pattern = '*',
  callback = function()
    vim.diagnostic.hide()
  end,
})

-- vim.api.nvim_create_autocmd('CursorHold', {
--   pattern = '*',
--   callback = function()
--     local hover_opts = {
--       focusable = false,
--       close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
--       border = 'rounded',
--       source = 'always',
--     }
--     vim.diagnostic.open_float(nil, hover_opts)
--   end,
-- })

vim.api.nvim_create_autocmd('VimResized', {
  pattern = '*',
  command = 'wincmd =',
})

vim.api.nvim_create_autocmd('RecordingEnter', {
  callback = function()
    _G.is_recording = true
    vim.cmd 'redrawstatus'
  end,
})
vim.api.nvim_create_autocmd('RecordingLeave', {
  callback = function()
    _G.is_recording = false
    vim.cmd 'redrawstatus'
  end,
})
