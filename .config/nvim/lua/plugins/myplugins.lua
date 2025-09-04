local overrides = require("configs.overrides")

---@type NvPluginSpec[]
local plugins = {

    -- Override plugin definition options

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- TODO add format & linting
            -- {
            --   "jose-elias-alvarez/null-ls.nvim",
            --   config = function()
            --     require "configs.null-ls"
            --   end,
            -- },
        },
        config = function()
            require "nvchad.configs.lspconfig"
            require "configs.lspconfig"
        end, -- Override to setup mason-lspconfig
    },

    -- override plugin configs
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
        "telescope.nvim",
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            config = function()
                require("telescope").load_extension("fzf")
            end,
        },
    }

    --  Breaks current line highlighting. TODO try loaded after
    -- {
    --   "folke/todo-comments.nvim",
    --     -- after = "base46",
    --   config = function()
    --       require("todo-comments").setup()
    --   end,
    -- },

    -- To make a plugin not be loaded
    -- {
    --   "NvChad/nvim-colorizer.lua",
    --   enabled = false
    -- },

    -- Uncomment if you want to re-enable which-key
    -- {
    --   "folke/which-key.nvim",
    --   enabled = true,
    -- },
}

return plugins
