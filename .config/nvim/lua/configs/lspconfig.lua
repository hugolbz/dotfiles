require("nvchad.configs.lspconfig").defaults()

local servers = { "lua_ls", "tinymist", "clangd", "ruff", "pylsp" }

-- read :h vim.lsp.config for changing options of lsp servers

-- Line length is set in pyproject.toml
vim.lsp.config.ruff = {
    --     cmd = {
    --         'ruff',
    --         'server',
    --         '--config', 'line-length=100',
    --     },
    init_options = {
        settings = {
            -- logLevel = 'debug',
        }
    }
}

vim.lsp.config.pylsp = {
    settings = {
        pylsp = {
            plugins = {
                -- Disable all linting and formatting plugins
                autopep8 = { enabled = false },
                black = { enabled = false },
                flake8 = { enabled = false },
                mccabe = { enabled = false },
                pycodestyle = { enabled = false },
                pydocstyle = { enabled = false },
                pyflakes = { enabled = false },
                pylint = { enabled = false },
                pylsp_black = { enabled = false },
                pylsp_isort = { enabled = false },
                pylsp_mypy = { enabled = false },
                yapf = { enabled = false },
                -- Keep navigation-related plugins enabled
                rope_completion = { enabled = true },
                jedi_completion = { enabled = true },
                jedi_definition = { enabled = true },
                jedi_hover = { enabled = true },
                jedi_references = { enabled = true },
                jedi_signature_help = { enabled = true },
                jedi_symbols = { enabled = true },
            }
        }
    }
}

vim.lsp.config.clangd = {
    cmd = {
        'clangd',
        '--clang-tidy',
        '--background-index',
        "--header-insertion=never",
        -- '--offset-encoding=utf-16',
    },
    -- root_markers = { '.clangd', 'compile_commands.json' },
    -- filetypes = { 'c', 'cpp' },
}

-- Must be called after config
vim.lsp.enable(servers)
