-- custom/plugins/configs.lua file

local M = {}

M.treesitter = {
   ensure_installed = {
      "python",
      "bash",
      "c",
      "cpp",
      "perl",
      "latex",
      "lua",
      "make",
      "yaml",
      "markdown",
   },
   highlight = {
       enable = true,
       disable = function(lang, bufnr) -- Disable in large C++ buffers
           return (lang == "c" or lang == "cpp") and vim.api.nvim_buf_line_count(bufnr) > 5000
       end,
   },
}

-- M.nvimtree = {
--    git = {
--       enable = true,
--    },
--    view = {
--       side = "right",
--       width = 20,
--    },
-- }

-- you cant directly call a module in chadrc thats related to the default config 
-- Thats because most probably that module is lazyloaded
-- In this case its 'cmp', we have lazyloaded it by default
-- So you need to make this override field a function, instead of a table 
-- And the function needs to return a table!

-- M.cmp = function()
--    local cmp = require 'cmp' 
--
--    return {
--       mapping = {
--          ["<C-d>"] = cmp.mapping.scroll_docs(-8),
--       }
--     }
-- end

-- M.plugins = {
--     -- enable dashboard
--     user = {
--         ["goolord/alpha-nvim"] = {
--             disable = false,
--         },
--     },
--     -- To remove plugins
--     remove = {
--         "NvChad/nvterm",
--     },
-- }
return M
