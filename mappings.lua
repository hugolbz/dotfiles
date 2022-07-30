-- n, v, i, t = mode names

local M = {}

-- Does not work for secondary leader :/
-- M.mine = {
--    n = {
--       [" "] = { "<leader>" }, -- alternative leader
--    }
-- }

M.spell = {
   n = {
      ["<leader>lf"] = { "<cmd> setlocal spell spelllang=fr<cr>", "  Change lang to fr" },
      ["<leader>le"] = { "<cmd> setlocal spell spelllang=en<cr>", "  Change lang to en" },
      ["<leader>ln"] = { "<cmd> setlocal spell spelllang=<cr>", "  Turn off spell" },
   }
}

M.telescope = {
   n = {
      -- find
      ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "  find files" },
      ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "  find all" },
      ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "   live grep" },
      ["<leader>fg"] = { "<cmd> Telescope live_grep <CR>", "   live grep" },
      ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "  find buffers" },
      ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "  help page" },
      ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "   find oldfiles" },
      ["<leader>fs"] = { "<cmd> Telescope grep_string <CR>", "   find string under cursor" },
      ["<leader>fr"] = { "<cmd> Telescope resume <CR>", "   resume last search" },
      ["<leader>tk"] = { "<cmd> Telescope keymaps <CR>", "   show keys" },

      -- git
      ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "   git commits" },
      ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "  git status" },

      -- pick a hidden term
      ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "   pick hidden term" },

      -- theme switcher
      ["<leader>th"] = { "<cmd> Telescope themes <CR>", "   nvchad themes" },
   },
}

return M
