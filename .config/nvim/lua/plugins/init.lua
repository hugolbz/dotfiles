return {
    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        config = function()
            require "configs.conform"
        end,
    },

    {
        "nvim-tree/nvim-tree.lua",
        opts = {
            git = { enable = true },
        },
    },
}
