local options = {
  showmode = false,
  confirm = true,
  breakindent = true,
  cc = '80,120',
  cmdheight = 1,
  -- NOTE: completeopt removed — blink.cmp manages this at runtime
  copyindent = true,
  cursorline = false,
  expandtab = true,
  softtabstop = -1, -- mirror shiftwidth: <BS> deletes a full indent stop in insert mode
  fileencoding = 'utf-8',
  fillchars = {
    diff = '╱',
    eob = ' ',
    fold = ' ',
    foldinner = '│', -- Nvim 0.12: line shown inside collapsed folds
    horiz = '━',
    horizdown = '┳',
    horizup = '┻',
    msgsep = '‾',
    vert = '┃',
    verthoriz = '╋',
    vertleft = '┫',
    vertright = '┣',
  },
  foldcolumn = '1',
  foldenable = true,
  foldexpr = 'v:lua.vim.treesitter.foldexpr()',
  foldlevel = 99,
  foldlevelstart = -1,
  foldmethod = 'expr',
  formatexpr = "v:lua.require'conform'.formatexpr()",
  -- NOTE: 'hidden' removed — default true in Neovim
  ignorecase = true,
  inccommand = 'split',
  -- NOTE: 'incsearch' removed — default true in Neovim
  list = true,
  listchars = 'tab:→ ,leadtab:» ,nbsp:␣,trail:•,extends:⟩,precedes:⟨', -- leadtab: Nvim 0.12
  modeline = true,
  modelines = 5,
  mouse = 'a',
  mousemodel = 'extend',
  number = true,
  preserveindent = true,
  pumheight = 10,
  redrawtime = 10000,
  report = 9001,
  scrolloff = 10,
  sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions',
  shiftwidth = 2,
  showbreak = '↪\\',
  signcolumn = 'yes:2',
  smartcase = true,
  -- NOTE: 'startofline' removed — Nvim default is false (preserves column on G/gg/<C-d>)
  spell = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  synmaxcol = 125,
  tabstop = 2,
  -- NOTE: 'termguicolors' removed — default true since Nvim 0.10
  -- NOTE: 'ttyfast' removed — no-op in Neovim (Vim legacy option)
  -- NOTE: 'autoindent' removed — default true in Neovim
  -- NOTE: 'equalalways' removed — default true in Neovim
  -- NOTE: 'encoding' removed — read-only after startup; fileencoding is set above
  timeoutlen = 100,
  undofile = true,
  updatetime = 100,
  wildignorecase = true,
  wrap = false,

  -- Nvim 0.12
  pumborder = 'rounded',
  winborder = 'rounded',
  messagesopt = 'hit-enter,history:500,progress:c',
  chistory = 10, -- quickfix stack depth (:colder/:cnewer levels)
  lhistory = 10, -- loclist stack depth  (:lolder/:lnewer levels)
  maxsearchcount = 9999, -- raise cap for n/N match count display (default 999)
  pummaxwidth = 50, -- limit completion popup width (pumheight already set above)
  jumpoptions = 'view', -- save/restore scroll position on jumplist and tagstack pop
}

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

for k, v in pairs(options) do
  vim.opt[k] = v
end
