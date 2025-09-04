require("nvchad.configs.lspconfig").defaults()

local servers = { "lua_ls", "tinymist", "clangd", "pylsp" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers

vim.lsp.config.pylsp = {
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    -- ignore = {'W391'},
                    maxLineLength = 100
                }
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
        '--offset-encoding=utf-16',
    },
    -- root_markers = { '.clangd', 'compile_commands.json' },
    -- filetypes = { 'c', 'cpp' },
}
