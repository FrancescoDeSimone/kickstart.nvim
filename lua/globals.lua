local globals = {
  colorizing_enabled = 1,
  disable_autoformat = false,
  disable_diagnostics = false,
  first_buffer_opened = false,
  have_nerd_font = true,
  loaded_perl_provider = 0,
  loaded_python_provider = 0,
  loaded_ruby_provider = 0,
  mapleader = ' ',
  maplocalleader = ' ',
  spell_enabled = true,
  vimtex_callback_progpath = 'nvim',
  vimtex_enabled = true,
  vimtex_view_method = 'zathura',
}

for k, v in pairs(globals) do
  vim.g[k] = v
end
