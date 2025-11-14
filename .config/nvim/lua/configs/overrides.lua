local M = {}

M.treesitter = {
    ensure_installed = {
        "bash",
        "bitbake",
        "c",
        "cmake",
        "cpp",
        "css",
        "doxygen",
        "git_config", "gitcommit", "git_rebase", "gitignore", "gitattributes",
        "html",
        "javascript",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "perl",
        "proto",
        "python",
        "robot",
        "ssh_config",
        "tcl",
        "typst",
        "vim",
        "yaml",
        -- "latex",
    },
    indent = {
        enable = true,
        disable = {
            "python"
        },
    },
    highlight = {
        enable = true,
        disable = function(lang, bufnr) -- Disable in large C++ buffers
            return (lang == "c" or lang == "cpp") and vim.api.nvim_buf_line_count(bufnr) > 5000
        end,
    },
}

M.mason = {
    ensure_installed = {
        -- lua stuff
        "lua-language-server",
        "stylua",

        -- C/C++
        "codelldb",
        "clangd",

        -- Python
        "pylint",
        "python-lsp-server",
        "debugpy",

        -- shell
        "shfmt",
        "shellcheck",

        -- typst
        "tinymist",
    },
}

-- git support in nvimtree
M.nvimtree = {
    git = {
        enable = true,
    },

    renderer = {
        highlight_git = true,
        icons = {
            show = {
                git = true,
            },
        },
    },
}

return M
