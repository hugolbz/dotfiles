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

M.plugins = {
   user = require "custom.plugins"
}

-- M.plugins = {
--   override = {},
--   remove = {},
--   user = {},
--   options = {
--     lspconfig = {
--       setup_lspconf = "", -- path of lspconfig file
--     },
--   },
-- }

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
