return {
  'kawre/leetcode.nvim',
  cmd = 'Leet',
  dependencies = {
    -- telescope removed — using snacks picker instead
    'MunifTanjim/nui.nvim',
  },
  opts = {
    logging = false,
    picker = { provider = 'snacks' },
    hooks = {
      question_enter = {
        function(q)
          vim.schedule(function()
            if not (q and q.bufnr and vim.api.nvim_buf_is_valid(q.bufnr)) then
              return
            end
            vim.b[q.bufnr].disable_autoformat = true
            vim.b[q.bufnr].disable_lint = true
            vim.diagnostic.enable(false, { bufnr = q.bufnr })
            for _, client in ipairs(vim.lsp.get_clients { bufnr = q.bufnr }) do
              vim.lsp.buf_detach_client(q.bufnr, client.id)
            end
          end)
        end,
      },
    },
  },
}
