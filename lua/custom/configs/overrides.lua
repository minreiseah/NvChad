local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "cpp",
    "markdown",
    "markdown_inline",
    "rust",
    "python",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
  highlight = {
    enable = false,
  }
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- python,
    "pyright",
  },
}

-- git support in nvimtree
local function nvimtree_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = false, silent = true, nowait = true}
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', '.', api.node.run.system, opts('Run System'))
  vim.keymap.set('n', 's', "", opts('Unbind s'))
end

M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },

  on_attach = nvimtree_on_attach,
}

-- M.cmp = function()
--   local disabled_filetypes = {
--     'markdown',
--     'txt',
--     'log',
--     'tex',
--   }
--
--   local filetype = vim.bo.filetype
--
--   for _, ft in ipairs(disabled_filetypes) do
--     if filetype == ft then
--       return {
--         sources = {}
--       }
--     end
--   end
--
--   return {
--     sources = {
--       { name = "nvim_lsp", max_item_count = 4 },
--       { name = 'nvim_lsp_signature_help', max_item_count=4 },
--       { name = "nvim_lua", max_item_count = 4 },
--       -- { name = "buffer", max_item_count = 4 },
--       -- { name = "path", max_item_count = 4 },
--       -- { name = "luasnip", max_item_count = 4 },
--     }
--   }
-- end

return M
