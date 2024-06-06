require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<leader>fm", function()
  require("conform").format()
end, { desc = "File Format with conform" })

map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

-- Center after going to next search
map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "*", "*zz")
map("n", "#", "#zz")
map("n", "g*", "g*zz")
map("n", "g#", "g#zz")

-- TODO Does not work for secondary leader :/
map("n", ",", " ")

-- Spell
map("n", "<leader>lf", "<cmd> setlocal spell spelllang=fr<cr>", { desc = "  Change lang to fr" })
map("n", "<leader>le", "<cmd> setlocal spell spelllang=en<cr>", { desc = "  Change lang to en" })
map("n", "<leader>ln", "<cmd> setlocal spell spelllang=<cr>",   { desc = "  Turn off spell" })

-- Comment
-- toggle comment in both modes
map("n", "<leader>:", function()
    require("Comment.api").toggle.linewise.current()
end, { desc = "toggle comment"})
-- TODO
-- map("v", "<leader>:", function()
--       "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>"
-- end, { desc = "toggle comment"})


-- Telescope
-- find
map("n", "<leader>ff", "<cmd> Telescope find_files <CR>", { desc = "  find files" })
map("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", { desc = "  find all" })
map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>", { desc = "   live grep" })
map("n", "<leader>fg", "<cmd> Telescope live_grep <CR>", { desc = "   live grep" })
map("n", "<leader>fb", "<cmd> Telescope buffers <CR>", { desc = "  find buffers" })
map("n", "<leader>fh", "<cmd> Telescope help_tags <CR>", { desc = "?  help page" })
map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>", { desc = "   find oldfiles" })
map("n", "<leader>fs", "<cmd> Telescope grep_string <CR>", { desc = "   find string under cursor" })
map("n", "<leader>fr", "<cmd> Telescope resume <CR>", { desc = "   resume last search" })
map("n", "<leader>tk", "<cmd> Telescope keymaps <CR>", { desc = "   show keys" })
-- git
map("n", "<leader>fc", "<cmd> Telescope git_commits <CR>", { desc = "   git commits" })
map("n", "<leader>ft", "<cmd> Telescope git_status <CR>", { desc = "  git status" })
-- pick a hidden term
map("n", "<leader>pt", "<cmd> Telescope terms <CR>", { desc = "   pick hidden term" })
-- theme switcher
map("n", "<leader>th", "<cmd> Telescope themes <CR>", { desc = "   nvchad themes" })

-- Disabled (tab collides with ctrl+I)
vim.keymap.del('n', '<tab>')
vim.keymap.del('n', '<S-tab>')

-- tabufline
map("n", "<leader>k", function()
    require("nvchad.tabufline").next()
end, { desc = "Goto next buffer"})
map("n", "<leader>j", function()
    require("nvchad.tabufline").prev()
end, { desc = "Goto previous buffer"})

-- Gitsigns navigation
map('n', ']c', function()
    if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
    else
        require('gitsigns').nav_hunk('next')
    end
end,
    { desc = "Next git hunk" }
)

map('n', '[c', function()
    if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
    else
        require('gitsigns').nav_hunk('prev')
    end
end,
    { desc = "Previous git hunk" }
)

