---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["n"] = { "nzz" },
    ["N"] = { "Nzz" },
    ["*"] = { "*zz" },
    ["#"] = { "#zz" },
    ["g*"] = { "g*zz" },
    ["g#"] = { "g#zz" },
  },
}

-- TODO Does not work for secondary leader :/
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

M.comment = {
  plugin = true,

  -- toggle comment in both modes
  n = {
    ["<leader>:"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "toggle comment",
    },
  },

  v = {
    ["<leader>:"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "toggle comment",
    },
  },
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
      ["<leader>fc"] = { "<cmd> Telescope git_commits <CR>", "   git commits" },
      ["<leader>ft"] = { "<cmd> Telescope git_status <CR>", "  git status" },

      -- pick a hidden term
      ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "   pick hidden term" },

      -- theme switcher
      ["<leader>th"] = { "<cmd> Telescope themes <CR>", "   nvchad themes" },
   },
}

M.disabled = {
  n = {
      ["<tab>"] = "",
      ["<S-tab>"] = ""
  }
}

M.tabufline = {
  n = {
    -- cycle through buffers
    ["<leader>k"] = {
      function()
        require("nvchad.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },

    ["<leader>j"] = {
      function()
        require("nvchad.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },
  },
}

return M
