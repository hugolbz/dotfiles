-- custom/plugins/init.lua has to return a table
-- The plugin name is github user or organization name/reponame

return {

    ['lewis6991/spellsitter.nvim'] = {
        after = "nvim-treesitter",
        config = function()
            require('spellsitter').setup()
        end,

    },

    ["folke/todo-comments.nvim"] = {
        after = "base46",
        config = function()
            require("todo-comments").setup()
        end,
    }

        -- use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        -- use {'nvim-treesitter/nvim-treesitter-textobjects'}
        -- use {'nvim-treesitter/nvim-treesitter-refactor'}
        -- use 'yamatsum/nvim-cursorline' -- highlight current line

        -- ["goolord/alpha-nvim"] = {
        --     disable = false
        -- },

        -- ["jose-elias-alvarez/null-ls.nvim"] = {
        --     after = "nvim-lspconfig",
        --     config = function()
        --         require "custom.plugins.null-ls"
        --     end,
        -- },
        --
}
