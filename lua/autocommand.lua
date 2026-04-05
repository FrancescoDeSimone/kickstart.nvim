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

-- Nvim 0.12 new highlight groups — styled for gruber-darker.
-- Applied on every ColorScheme change so they survive theme reloads.
vim.api.nvim_create_autocmd('ColorScheme', {
  group = misc_group,
  pattern = '*',
  callback = function()
    -- Added chars within a changed diff line (complements DiffText for the whole region)
    vim.api.nvim_set_hl(0, 'DiffTextAdd', { fg = '#73d936', bold = true })
    -- Active snippet tabstop indicator (blink.cmp + friendly-snippets)
    vim.api.nvim_set_hl(0, 'SnippetTabstopActive', { sp = '#ffdd33', underline = true })
    -- Message type highlights (shown by ui2 / :terminal / shell commands)
    vim.api.nvim_set_hl(0, 'OkMsg', { fg = '#73d936' })
    vim.api.nvim_set_hl(0, 'StderrMsg', { fg = '#f43841' })
    vim.api.nvim_set_hl(0, 'StdoutMsg', { fg = '#96a6c8' })
  end,
})
-- Apply immediately for the current session (before the next :colorscheme load)
vim.api.nvim_exec_autocmds('ColorScheme', { group = 'kickstart-misc' })
