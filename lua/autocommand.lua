vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

local diag_group = vim.api.nvim_create_augroup('kickstart-disable-diagnostic', { clear = true })

vim.api.nvim_create_autocmd('InsertLeave', {
  group = diag_group,
  callback = function()
    vim.diagnostic.show(nil, vim.api.nvim_get_current_buf())
  end,
})

vim.api.nvim_create_autocmd('InsertEnter', {
  group = diag_group,
  callback = function()
    vim.diagnostic.hide(nil, vim.api.nvim_get_current_buf())
  end,
})

local misc_group = vim.api.nvim_create_augroup('kickstart-misc', { clear = true })

vim.api.nvim_create_autocmd('VimResized', {
  group = misc_group,
  callback = function()
    vim.cmd 'wincmd ='
  end,
})

-- Restore cursor to last known position when reopening a file
vim.api.nvim_create_autocmd('BufReadPost', {
  group = misc_group,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Nvim 0.12: Clear LSP state before restoring a session
vim.api.nvim_create_autocmd('SessionLoadPre', {
  group = misc_group,
  callback = function()
    -- Close all floating windows to avoid stale LSP popups
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_config(win).relative ~= '' then
        pcall(vim.api.nvim_win_close, win, false)
      end
    end
  end,
})

-- FileType-specific settings
local ft_group = vim.api.nvim_create_augroup('kickstart-filetype', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = ft_group,
  pattern = 'gitcommit',
  callback = function()
    vim.opt_local.textwidth = 72
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = ft_group,
  pattern = 'markdown',
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.conceallevel = 2
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = ft_group,
  pattern = 'help',
  callback = function()
    vim.opt_local.list = false
    vim.opt_local.spell = false
    vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = true, desc = 'Close help' })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = ft_group,
  pattern = 'qf',
  callback = function()
    vim.opt_local.spell = false
    vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = true, desc = 'Close quickfix' })
  end,
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
    -- Symbol being renamed (vim.lsp.buf.rename visual indicator, Nvim 0.12)
    vim.api.nvim_set_hl(0, 'LspReferenceTarget', { fg = '#ffdd33', bold = true })
  end,
})
-- Apply immediately for the current session (before the next :colorscheme load)
vim.api.nvim_exec_autocmds('ColorScheme', { group = 'kickstart-misc' })
