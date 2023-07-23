---@type MappingsTable
local M = {}

M.general = {
  n = {
    -- [";"] = { ":", "enter command mode", opts = { nowait = true } },

  },
}

-- more keybinds!
M.custom = {
  n = {
    ["te"] = { ":tabedit<CR>", "open a new tab" },
    ["sv"] = { ":vsplit<CR>" },
    ["ss"] = { ":split<CR><C-w>w" },
    ["sh"] = { "<C-w>h", "focus left" },
    ["sj"] = { "<C-w>j", "focus down" },
    ["sk"] = { "<C-w>k", "focus up" },
    ["sl"] = { "<C-w>l", "focus right" },
  }
}

M.lspconfig = {
  plugin = true,

  n = {
    ["cd"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },

    ["<C-j>"] = {
      function()
        vim.diagnostic.goto_next({ float = { border = "rounded" }})
      end,
      "Goto next diagnostic",
    },

    ["gh"] = {
      function()
        vim.lsp.buf.references()
      end,
      "LSP references",
    },
  }
}

M.telescope = {
  plugin=true,

  n = {
    [';f'] = {
      function()
        require('telescope.builtin').find_files({
          no_ignore = false,
          hidden = true
        })
      end, "Find Files"},

    [";r"] = {
      function()
        require('telescope.builtin').live_grep({
          no_ignore = true,
          hidden = true
        })
      end, "Live Grep" },

    ["\\\\"] = {
      function()
        require('telescope.builtin').buffers()
      end, "Show buffers" },

    [";;"] = {
      function()
        require('telescope.builtin').resume()
      end, "Resume" },

    [";e"] = {
      function()
        require('telescope.builtin').diagnostics()
      end, "Show Diagnostics" },

    ["sf"] = {
      function()
        require('telescope').extensions.file_browser.file_browser({
          path = "%:p:h",
          cwd = vim.fn.expand('%:p:h'),
          respect_gitignore = false,
          hidden = true,
          grouped = true,
          previewer = false,
          initial_mode = "normal",
          layout_config = { height = 40 }
        })
      end, "File Browser"
    }
  }
}



return M
