local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp
  },

  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = "Telescope",
    init = function()
      require("core.utils").load_mappings "telescope"
    end,
    opts = overrides.telescope,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "telescope")
      local telescope = require "telescope"
      telescope.setup(opts)

      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
    lazy = false,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim" },
    lazy = false,
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' ,
    lazy = false,
  },

  {
    'lervag/vimtex',
    lazy = false,
    config = function()
      vim.g.tex_flavor='latex'
      vim.g.vimtex_view_method='zathura'
      vim.g.vimtex_quickfix_mode = 0

      -- vim.g.vimtex_view_general_viewer = 'okular'
      -- vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]

      -- vim.g.vimtex_quickfix_enabled = 1
      -- vim.g.vimtex_syntax_enabled = 1

      -- only conceals .tex files
      vim.g.tex_conceal = 'abdgm'
      vim.cmd[[ autocmd BufNewFile,BufRead *.tex setlocal conceallevel=2 ]]
      vim.cmd[[ hi clear Conceal ]]
      vim.g.vimtex_syntax_conceal = {
        accents = 1,
        ligatures = 1,
        cites = 1,
        fancy = 0,
        greek = 1,
        math_bounds = 1,
        math_delimiters = 1,
        math_fracs = 1,
        math_super_sub = 1,
        math_symbols = 1,
        sections = 1,
        styles = 1,
      }

      -- selective highlighting
      vim.g.tex_fast = ""

      vim.g.vimtex_syntax_custom_cmds = {
        {name = 'boldsymbol', conceal = 1},
        {name = 'boldsymbol', mathmode = 1, conceal = 1},
        {name = 'textbf', conceal = 1},
        {name = 'textbf', mathmode = 1, conceal = 1},
      }

      -- Save file on exiting Insert Mode
      -- vim.cmd[[ autocmd InsertLeave *.tex update ]]

      vim.g.vimtex_compiler_latexmk = {
        aux_dir = 'out',
        out_dir = 'out',
        callback = 1,
        continuous = 1,
        executable = 'latexmk',
        hooks = {},
        options = {
          '-verbose',
          '-file-line-error',
          '-synctex=1',
          '-interaction=nonstopmode',
        },
      }
    end,
  },

  {
    "SirVer/ultisnips",
    config = function()
      -- vim.g.UltiSnipsExpandTrigger = "<tab>"
      vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
      vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
      vim.g.UltiSnipsSnippetDirectories = {vim.fn.expand("$HOME") .. "/.config/nvim/UltiSnips"}
    end,
    lazy = false,

  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
