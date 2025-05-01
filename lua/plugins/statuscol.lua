return {
  'luukvbaal/statuscol.nvim',
  config = function()
    require('statuscol').setup {
      {
        relculright = true,
        segments = {
          { click = 'v:lua.ScFa', hl = 'FoldColumn', text = { require('statuscol.builtin').foldfunc } },
          { click = 'v:lua.ScSa', sign = { auto = true, maxwidth = 2, name = { '.*' }, namespace = { '.*' }, text = { '.*' } } },
          { click = 'v:lua.ScLa', text = { ' ', require('statuscol.builtin').lnumfunc, ' ' } },
          { click = 'v:lua.ScSa', sign = { auto = true, colwidth = 1, maxwidth = 2, name = { '.*' }, wrap = true } },
        },
      },
    }
  end,
}
