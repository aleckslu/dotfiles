-- Localize
local vim = vim

--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
-- try bsp as leader?
-- g.maplocalleader = '<BS>'

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'
-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set length of indents/tabs

-- this block worked
vim.opt.tabstop = 8
vim.opt.expandtab = false
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- from someones dotfiles
-- opt.expandtab = true
-- opt.shiftwidth = 4
-- opt.smartindent = true
-- opt.softtabstop = 4
-- opt.tabstop = 4

-- others
-- opt.smarttab = false
-- opt.vartabstop = '4'

-- disable LSPs from setting tabstop (not sure what else it does)
-- TODO: look into what else this does

-- vim.g.base46_cache = vim.fn.stdpath 'data' .. '/base46_cache/'
vim.g.editorconfig = false

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- vim.opt.clipboard = ''
if vim.fn.has 'wsl' == 1 then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
    paste = {
      ['+'] = 'pwsh.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ['*'] = 'pwsh.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end

vim.opt.breakindent = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

vim.opt.spellfile = { vim.fs.joinpath(vim.fn.stdpath 'config', 'spell/en.utf-8.add') }

-- [[ Shell / Terminal Opts ]]
if vim.fn.has 'win32' == 1 then
  -- :h shell-powershell
  vim.opt.shell = 'pwsh'
  vim.opt.shellcmdflag = '-nologo -noprofile -ExecutionPolicy RemoteSigned -command'
  vim.opt.shellxquote = ''
elseif vim.fn.has 'wsl' == 1 then
  vim.opt.shell = 'zsh'
end

-- [[ BASIC KEYMAPS ]]

local map = vim.keymap.set
-- remapping redo
map('n', 'U', '<C-r>')

-- remapping : and ;
map({ 'n', 'v' }, ';', ':', { noremap = true })
map({ 'n', 'v' }, ':', ';', { noremap = true })

-- Yanking/Deleting optimizations
map({ 'n', 'x' }, 'x', '"_x')
map({ 'n', 'x' }, '<leader>d', [["_d]], { desc = '[d] into Void' })
-- set({ 'n', 'v' }, '<leader>D', [["_D]], { desc = '[D] into Void' }) -- Existing keymap LSP: Type Def
map('x', '<leader>P', [["_dP]], { desc = '[P]aste w/o Register Change' })
map({ 'x' }, '<leader>y', [["+y]], { desc = '[Y]ank to Clipboard' })
map('n', '<leader>Y', [["+y$]], { desc = '[Y]ank Right' })
map('x', '<leader>Y', [["+y$]], { desc = '[Y]ank Right' })
map('n', '<leader>yy', [["+yy]], { desc = '[Y]ank Line' })
map({ 'n', 'x' }, '<leader>p', [["+p]], { desc = '[P]aste' })
-- yank filepath
map(
  'n',
  '<leader>yf',
  ':let @+ = expand("%:p")<cr>:lua print("Yanked filepath to system clipboard: " .. vim.fn.expand("%:p"))<cr>',
  { desc = '[Y]ank [F]ilepath', silent = true }
)
-- yank parent dir path
local function yank_dir_path()
  local fullpath = vim.api.nvim_buf_get_name(0)
  if fullpath == '' then
    return
  end
  local parent_dir = vim.fn.fnamemodify(fullpath, ':p:h')
  parent_dir = vim.fn.fnamemodify(parent_dir, ':p:h')
  vim.fn.setreg('+', parent_dir)
  print('Yanked parent path to system clipboard: ' .. parent_dir)
end
map('n', '<leader>yd', yank_dir_path, { desc = '[Y]ank [D]ir Path' })

-- [[ Navigation ]]
-- Move Lines
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move Line Down', silent = true })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move Line Up', silent = true })
-- set('v', 'J', 'Dp', { desc = 'Move Line Down' }) -- 'gv' doesnt select bc line was deleted
-- set('v', 'K', 'Dkkp', { desc = 'Move Line Up' }) ---^

-- Maintains cursor positions for smoother jumping
map('n', 'J', 'mzJ`z')
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- [[ Buffers ]] --
-- More buffer keymaps in bufferline config

map('n', '<leader>q', require('custom.util').bufdelete, { desc = 'Quit Buffer' })

-- [[ Panes ]]
-- TODO: make a function that `:tab split` when no other window, and will :q when focussed tab is 2nd tab index or higher.
-- FIX: will mean you don't plan to use nvim's builtin windows/tabs
map('n', '<leader>f', require 'custom.util.toggle-fullscreen', { desc = '[F]ullscreen (New Tab)' })

-- Resize window using <ctrl> arrow keys
-- TODO: Make it expand to a specific direction instead
map('n', '<C-Up>', '<cmd>resize +3<cr>', { desc = 'Increase Window Height' })
map('n', '<C-Down>', '<cmd>resize -3<cr>', { desc = 'Decrease Window Height' })
map('n', '<C-Left>', '<cmd>vertical resize -3<cr>', { desc = 'Decrease Window Width' })
map('n', '<C-Right>', '<cmd>vertical resize +3<cr>', { desc = 'Increase Window Width' })

-- Set highlight on search, but clear on pressing <Esc> in normal modereplace term
vim.opt.hlsearch = true
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- [[ DEBUGGING / LOGGING KEYMAPS ]]
map('n', '<leader>lg', ":lua for k, v in pairs(vim.api.nvim_exec('let g:', true) do vim.print(k, v) end", { desc = '[G]lobals' })
map('n', '<leader>lp', ':lua vim.print(<C-R>+)', { desc = '[P]aste (+ reg)' })
map('n', '<leader>lP', ':lua vim.print(<C-R>")', { desc = '[P]aste (" reg)' })
map('n', '<leader>li', ':lua vim.print()<LEFT>', { desc = '[I]nspect' })
map('n', '<leader>lr', ':lua vim.print(require(""))<LEFT><LEFT><LEFT>', { desc = '[R]equire' })
map('n', '<leader>ls', function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":lua vim.print(vim.fn.has_key(,'key'))" .. string.rep('<LEFT>', 8), true, false, true), 'n', false)
end, { desc = '[S]earch Obj (Table)' })
map('n', '<leader>le', ':lua vim.print(vim.env.)<LEFT>', { desc = '[E]nvs' })

-- [[ Diagnostic Keymaps ]]
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>se', vim.diagnostic.open_float, { desc = '[O]pen diagnostic [E]rror messages' })
map('n', '<leader>sE', vim.diagnostic.setloclist, { desc = '[O]pen diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
-- Move panes in terminal mode for  NOTE: toggleterm.nvim
map('t', '<C-h>', [[<Cmd>wincmd h<CR>]], { desc = 'Switch to Left Pane' })
map('t', '<C-j>', [[<Cmd>wincmd j<CR>]], { desc = 'Switch to Lower Pane' })
map('t', '<C-k>', [[<Cmd>wincmd k<CR>]], { desc = 'Switch to Upper Pane' })
map('t', '<C-l>', [[<Cmd>wincmd l<CR>]], { desc = 'Switch to Right Pane' })

map('n', 'Q', '<nop>')
map({ 'i', 'c', 't' }, '<F13>', '<nop>')

--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
--  [[ Move Windows ]]
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ AUTOCOMMANDS ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]] See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update

require('lazy').setup({
  -- 'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  {
    'akinsho/bufferline.nvim',
    version = '*',
    event = 'VeryLazy',
    keys = {
      { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
      { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
      { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    },
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      vim.opt.termguicolors = true
      require('bufferline').setup {
        options = {
          -- mode = 'buffers',
          always_show_bufferline = false,
          auto_toggle_bufferline = true,
          offsets = {
            {
              filetype = 'neo-tree',
              text = '',
              highlight = 'Directory',
              text_align = 'left',
            },
          },
        },
      }
    end,
  },

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      local whichkey = require 'which-key'
      whichkey.setup()
      whichkey.add {
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>b', group = '[B]uffers' },
        { '<leader>l', group = '[L]og (debug)' },
        -- [[ NO OPS ]]
        -- Disable Discord ptt key (F13)
        -- { '<F13>', '<nop>', hidden = true, mode = { 'i', 'c', 't' } },
        -- Disable Q Command Mode keymap
        -- { 'Q', '<nop>', hidden = true },
      }
    end,
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'BurntSushi/ripgrep',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      'nvim-treesitter/nvim-treesitter',
      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', lazy = true, enabled = vim.g.have_nerd_font },
      'debugloop/telescope-undo.nvim',
    },
    config = function()
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          layout_strategy = 'vertical',
          layout_config = { height = 0.92 },
          --   mappings = {
          --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
          --   },
          file_ignore_patterns = {
            -- '^Intel\\.*',
            -- '^Dell\\.*',
            -- '^OneDriveTemp\\.*',
            -- '^MSOCache\\.*',
            -- 'Riot Games\\.*',
            -- '^Program Files %(x86%)\\.*',
            -- '^C:\\spt\\.*',
            -- '^Windows\\.*',
            -- '^C:\\Program Files\\.*',
            -- '^Battlestate Games\\.*',
            -- '^Microsoft\\.*',
            -- '^%$WinREAgent\\.*',
            -- '^Strawberry\\.*',
            -- '%$WINDOWS%.~BT\\.*',
            -- '%$Windows%.~WS\\.*',
            -- '^QMK_MSYS\\.*',
            -- '^%$AV_AVG\\.*',
            -- '%$Recycle%.Bin\\.*',
            'Music\\.*',
            'Videos\\.*',
            'Video\\.*',
            '.git',
            'node_modules',
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          },
        },
      }
      -- require 'custom.themes.telescope-themes.telescope-vertical-layout'
      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      map('n', '<leader>sh', builtin.help_tags, { desc = '[H]elp' })
      map('n', '<leader>sk', builtin.keymaps, { desc = '[K]eymaps' })
      map('n', '<leader>sF', builtin.find_files, { desc = '[F]iles CWD' })
      -- search favorite dirs list through $Env:SEARCH_DIRS
      map('n', '<leader>sf', require('custom.util').find_files_in_favs, { desc = '[F]iles in Main Dirs' })
      map('n', '<leader>ss', builtin.builtin, { desc = '[S]elect Telescope Refs' })
      map('n', '<leader>sw', builtin.grep_string, { desc = 'current [W]ord' })
      map('n', '<leader>sG', builtin.live_grep, { desc = '[G]rep' })
      -- grep favorite dirs list through $Env:SEARCH_DIRS
      map('n', '<leader>sg', require('custom.util').grep_files_in_favs, { desc = '[G]rep' })
      map('n', '<leader>sd', builtin.diagnostics, { desc = '[D]iagnostics' })
      map('n', '<leader>sp', builtin.resume, { desc = '[P]revious Search' })
      map('n', '<leader>s.', builtin.oldfiles, { desc = '[.] Recent Files' })
      map('n', '<leader><leader>', require('custom.util').find_files_in_favs, { desc = '[ ] Find in Main Dirs' })
      -- search RESUMES Keymaps
      map('n', '<leader>sr', require('custom.util').find_cv_resume, { desc = '[R]esumes CVs' })

      -- Slightly advanced example of overriding default behavior and theme
      map('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      map('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      map('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  { -- [[ LSP Configuration & Plugins ]]
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            map('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>wS', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[S]ymbol LSP Search')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap.
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        -- tsserver = {},
        --

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        -- lua
        'stylua',
        'lua-language-server',
        -- latex
        -- 'ltex-ls',
        'latexindent',
        -- typescript / javascript
        'typescript-language-server',
        'prettier',
        'prettierd',
        'eslint-lsp',
        'eslint_d',
        'tailwindcss-language-server',
        'vue-language-server',
        -- html / css
        'emmet-ls',
        'css-lsp',
        'html-lsp',
        -- json
        'jsonlint',
        'json-lsp',
        -- python
        'python-lsp-server',
        'black',
        -- markdown
        'marksman',
        'markdown_oxide',
        -- powershell
        'powershell-editor-services',
        'ruby-lsp',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }
      -- json-lsp
      -- jsonlint

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            -- server.flags = vim.tbl_deep_extend('force', { debounce_text_changes = 1400 }, server.flags or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        python = { 'black' },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        javascript = { { 'prettierd', 'prettier' } },
      },
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline', -- for cmdline autocompletion
      'hrsh7th/cmp-buffer', -- for search / find autocompletion ('/')
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<down>'] = cmp.mapping.select_next_item(),

          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<up>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },
          ['<C-e>'] = cmp.mapping.abort,
          ['<Enter>'] = cmp.mapping.confirm { select = true },

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },

        -- `/` cmdline setup.
        cmp.setup.cmdline('/', {
          mapping = require('cmp').mapping.preset.cmdline(),
          sources = {
            { name = 'buffer' },
          },
        }),
        --
        -- -- `:` cmdline autocompletion setup.
        cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          -- mapping = cmp.mapping.preset.cmdline() {
          --   ['<C-G>'] = cmp.mapping.confirm { select = true },
          -- },
          sources = cmp.config.sources({
            { name = 'path' },
          }, {
            {
              name = 'cmdline',
              option = {
                ignore_cmds = { 'Man', '!' },
              },
            },
          }),
          matching = {
            disallow_symbol_nonprefix_matching = false,
            disallow_fuzzy_matching = false,
            disallow_fullfuzzy_matching = false,
            disallow_partial_matching = false,
            disallow_prefix_unmatching = false,
            disallow_partial_fuzzy_matching = false,
          },
        }),
        --
      }
    end,
  },
  -- { import = 'custom.themes' },
  -- { 'Mofiqul/dracula.nvim', lazy = false },
  -- {
  --   'navarasu/onedark.nvim',
  --   lazy = false,
  --   opts = { style = 'dark', colors = {}, highlights = {} },
  -- },
  -- {
  --   'AlexvZyl/nordic.nvim',
  --   lazy = false,
  -- },
  { 'sho-87/kanagawa-paper.nvim', lazy = false, opts = {
    dimInactive = true,
    keywordStyle = { bold = true },
  } },
  -- { -- You can easily change to a different colorscheme.
  --   -- Change the name of the colorscheme plugin below, and then
  --   -- change the command in the config to whatever the name of that colorscheme is.
  --   --
  --   -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  --   'folke/tokyonight.nvim',
  --   lazy = false,
  --   priority = 1000, -- Make sure to load this before all the other start plugins.
  --   opts = {
  --     plugins = {
  --       markdown = true,
  --     },
  --   },
  --   init = function()
  --     -- vim.cmd.colorscheme 'onedark'
  --     -- You can configure highlights by doing something like:
  --     -- vim.cmd.hi 'Comment gui=none'
  --   end,
  -- },
  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>st', '<CMD>TodoTelescope<CR>', { desc = '[S]earch [T]ODOs' } },
    },
    opts = { signs = false },
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Minimalistic Dashboard
      -- require('mini.starter').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin

      -- local statusline = require 'mini.statusline'
      -- -- set use_icons to true if you have a Nerd Font
      -- statusline.setup {
      --   -- content = {
      --   -- active = '',
      --   -- },
      --   use_icons = g.have_nerd_font,
      -- }
      --
      -- -- You can configure sections in the statusline by overriding their
      -- -- default behavior. For example, here we set the section for
      -- -- cursor location to LINE:COLUMN
      -- ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function()
      --   return '%2l:%-2v'
      -- end
      --
      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Highlight, edit, and navigate code
    -- TODO: treesitter "lazy loading" w/ reddit suggestion:
    -- local col = vim.fn.screencol()
    -- local row = vim.fn.screenrow()
    -- timer:start(5, 2, function()
    --   vim.schedule(function()
    --     local new_col = vim.fn.screencol()
    --     local new_row = vim.fn.screenrow()
    --     if new_row ~= row and new_col ~= col then
    --       if timer:is_active() then
    --         timer:close()
    --         begin_ts_highlight(bufnr, lang, "highligter")
    --       end
    --     end
    --   end)
    -- end)
    --
    -- https://www.reddit.com/r/neovim/comments/1d3v0rj/experiencing_lag_with_lualinenvim_on_neovim_v010/

    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash',
        'powershell',
        'c',
        --
        'javascript',
        'typescript',
        'vue',
        'html',
        'css',
        'json',
        'jq',
        'sql',
        'tsx',
        --
        'lua',
        'markdown',
        'markdown_inline',
        'vim',
        'vimdoc',
        'latex',
        'ruby',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.lint',
  { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    -- icons = {},
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- dofile(vim.g.base46_cache .. 'defaults')
-- dofile(vim.g.base46_cache .. 'statusline')
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
  dofile(vim.g.base46_cache .. v)
end

-- HACK: set current line number to orange
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = 'orange', bold = true })
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
