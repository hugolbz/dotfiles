require "nvchad.autocmds"

-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- Folding
-- Defer for big files, see https://github.com/nvim-treesitter/nvim-treesitter/issues/1100
-- Default to treesitter folding
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        vim.defer_fn(function()
            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            -- vim.opt.foldcolumn = "1"
            -- opt.foldtext = ""
            -- vim.opt.foldnestmax = 3
            vim.opt.foldlevel = 99
            -- vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
            -- vim.opt.foldlevelstart = 99
        end, 100)
    end,
})
-- Prefer LSP folding if client supports it
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client:supports_method('textDocument/foldingRange') then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
            -- vim.wo[win][0].foldtext = 'v:lua.vim.lsp.foldtext()'
        end
    end,
})

-- Autoformat on save
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp", { clear = true }),
    callback = function(args)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            callback = function()
                vim.lsp.buf.format { async = false, id = args.data.client_id }
            end,
        })
    end
})

-- autoread. See https://stackoverflow.com/questions/2490227/how-does-vims-autoread-work
vim.cmd [[
set autoread " neovim default
au FocusGained,BufEnter * :silent! !
au FocusLost,WinLeave * :silent! w
]]

-- Change makeprg to use bear
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp" },
    callback = function()
        vim.opt_local.makeprg = "bear -- make"
        vim.opt_local.commentstring = "// %s"
    end,
})
