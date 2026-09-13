return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  dependencies = {
    'OXY2DEV/markview.nvim',
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    local parsers = {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'regex',
      'rust',
      'cpp',
      'zig',
      'go',
      'gomod',
      'gosum',
      'typescript',
      'javascript',
      'tsx',
      'css',
      'python',
      'nix',
      'terraform',
      'hcl',
      'json',
      'yaml',
      'toml',
    }

    local treesitter = require 'nvim-treesitter'
    treesitter.setup()
    treesitter.install(parsers)

    local function is_large_buffer(buf)
      local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size and stats.size > 200 * 1024 then
        return true
      end
      return vim.api.nvim_buf_line_count(buf) > 5000
    end

    local function attach(buf, language)
      if is_large_buffer(buf) or not vim.treesitter.language.add(language) then
        return
      end

      vim.treesitter.start(buf, language)
      if vim.treesitter.query.get(language, 'indents') then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end

    local available_parsers = treesitter.get_available()
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local buf, filetype = args.buf, args.match
        local language = vim.treesitter.language.get_lang(filetype)
        if not language or is_large_buffer(buf) then
          return
        end

        if vim.list_contains(treesitter.get_installed 'parsers', language) then
          attach(buf, language)
        elseif vim.list_contains(available_parsers, language) then
          treesitter.install(language):await(function()
            if vim.api.nvim_buf_is_valid(buf) then
              attach(buf, language)
            end
          end)
        else
          attach(buf, language)
        end
      end,
    })

    local move = require 'nvim-treesitter-textobjects.move'
    require('nvim-treesitter-textobjects').setup { move = { set_jumps = true } }

    local mappings = {
      { ']f', 'goto_next_start', '@function.outer', 'Next function start' },
      { ']F', 'goto_next_end', '@function.outer', 'Next function end' },
      { '[f', 'goto_previous_start', '@function.outer', 'Previous function start' },
      { '[F', 'goto_previous_end', '@function.outer', 'Previous function end' },
      { ']c', 'goto_next_start', '@class.outer', 'Next class start' },
      { ']C', 'goto_next_end', '@class.outer', 'Next class end' },
      { '[c', 'goto_previous_start', '@class.outer', 'Previous class start' },
      { '[C', 'goto_previous_end', '@class.outer', 'Previous class end' },
      { ']a', 'goto_next_start', '@parameter.inner', 'Next parameter' },
      { ']A', 'goto_next_end', '@parameter.inner', 'Next parameter end' },
      { '[a', 'goto_previous_start', '@parameter.inner', 'Previous parameter' },
      { '[A', 'goto_previous_end', '@parameter.inner', 'Previous parameter end' },
    }

    for _, mapping in ipairs(mappings) do
      vim.keymap.set({ 'n', 'x', 'o' }, mapping[1], function()
        move[mapping[2]](mapping[3])
      end, { desc = mapping[4] })
    end
  end,
}
