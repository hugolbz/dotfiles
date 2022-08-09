local M = {}

-- M.options = {
--   -- load your options here or load module with options
--   user = function() end,
--
--   nvChad = {
--     update_url = "https://github.com/NvChad/NvChad",
--     update_branch = "main",
--   },
-- }

M.ui = {
  -- hl = highlights
  hl_add = {},
  hl_override = {},
  changed_themes = {},
  theme = "blossom",
  theme_toggle = {"monekai", "blossom"},
  statusline = {
      separator_style = "arrow",
  },
  transparency = false,
}

local pluginConfs = require "custom.plugins.configs"
M.plugins = {
   user = require "custom.plugins",
   override = {
       ["nvim-treesitter/nvim-treesitter"] = pluginConfs.treesitter,
       ["williamboman/mason.nvim"] = {
           ensure_installed = {
               -- lua stuff
               "lua-language-server",
               "stylua",

               -- C/C++
               "codelldb",
               "clangd",

               -- python
               "pylint",
               "python-lsp-server",
               "debugpy",

               -- shell
               "shfmt",
               "shellcheck",
           },
       },
   },
}

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
