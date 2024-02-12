local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "c",
    "markdown",
    "markdown_inline",
    "python",
    "bash",
    "cpp",
    "perl",
    "latex",
    "proto",
    "make",
    "yaml",
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
