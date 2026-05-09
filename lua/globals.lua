local globals = {
  disable_autoformat = true,
  have_nerd_font = true,
  loaded_node_provider = 0,
  loaded_perl_provider = 0,
  loaded_python3_provider = 0,
  loaded_ruby_provider = 0,
  mapleader = ' ',
  maplocalleader = ' ',
  rust_recommended_style = 0, -- prevent ftplugin/rust.vim from forcing sw=4/textwidth=100
}

for k, v in pairs(globals) do
  vim.g[k] = v
end
