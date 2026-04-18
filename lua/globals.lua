local globals = {
  disable_autoformat = true,
  disable_diagnostics = false,
  have_nerd_font = true,
  loaded_perl_provider = 0,
  loaded_python_provider = 0,
  loaded_ruby_provider = 0,
  mapleader = ' ',
  maplocalleader = ' ',
  rust_recommended_style = 0, -- prevent ftplugin/rust.vim from forcing sw=4/textwidth=100
}

for k, v in pairs(globals) do
  vim.g[k] = v
end
