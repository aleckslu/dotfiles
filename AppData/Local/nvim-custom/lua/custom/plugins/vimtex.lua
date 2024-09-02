return {
  'lervag/vimtex',
  init = function()
    -- Use init for configuration, don't use the more common "config".
    -- " This is necessary for VimTeX to load properly. The "indent" is optional.
    -- " Note that most plugin managers will do this automatically.
    -- filetype plugin indent on

    -- " This enables Vim's and neovim's syntax-related features. Without this, some
    -- " VimTeX features will not work (see ":help vimtex-requirements" for more
    -- " info).
    --
    -- syntax enable

    -- " Viewer options: One may configure the viewer either by specifying a built-in
    -- " viewer method:
    -- vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_view_method = 'general'
    -- vim.g.tex_flavor = 'latex'
    -- vim.g.tex_conceal = 'abdmgs'
    -- vim.g.vimtex_quickfix_mode = 0
    -- vim.g.vimtex_compiler_latexmk_engines = { ['_'] = '-lualatex' }
    -- vim.g.vimtex_view_enabled = 0
    -- vim.g.vimtex_view_automatic = 0
    -- vim.g.vimtex_indent_on_ampersands = 0
    -- vim.g.latexindent_opt = '-m'

    -- " Or with a geteric interface:
    vim.g.vimtex_view_general_viewer = 'SumatraPDF'
    -- vim.g.vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

    -- " VimTeX uses latexmk as the default compiler backend. If you use it, which is
    -- " strongly recommended, you probably don't need to configure anything. If you
    -- " want another compiler backend, you can change it as follows. The list of
    -- " supported backends and further explanation is provided in the documentation,
    -- " see ":help vimtex-compiler".
    -- vim.g.vimtex_compiler_method = 'latexrun'

    -- " Most VimTeX mappings rely on localleader and this can be changed with the
    -- " following line. The default is usually fine and is the symbol "\".
    -- let maplocalleader = ","
    vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
      pattern = '*.tex',
      once = true,
      callback = function()
        require('which-key').add {
          { '<leader>l', group = '[L]atex' },
        }
      end,
    })
  end,
}
