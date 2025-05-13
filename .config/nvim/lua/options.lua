require "nvchad.options"

-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

if vim.g.neovide then
    vim.g.neovide_scroll_animation_length = 0.1
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_cursor_animate_command_line = false
    vim.g.neovide_cursor_animate_in_insert_mode = false
end

vim.o.shell = "/bin/bash"

vim.opt.breakindent = true --Enable break indent
vim.opt.ignorecase = true --Case insensitive searching unless /C or capital in search

-- Indenting
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- :find path (:set path to display) 
-- opt.path:remove "/usr/include"
vim.opt.path:append "**"
-- vim.cmd [[set path=.,,,$PWD/**]] -- Alternatively set the path
vim.opt.wildignorecase = true
vim.opt.wildignore:append "build/*"
vim.opt.wildignore:append "**/.git/*"
vim.opt.wildignore:append "**/doc/doxygen/*"

-- Better diff
-- vim.o.diffopt = "internal,filler,closeoff,linematch:60"
vim.opt.diffopt="internal,filler,closeoff,indent-heuristic,linematch:60,algorithm:histogram"

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- Avertissement par flash (visual bell) plutôt que par beep
vim.opt.visualbell = true
--
-- Suffixes a cacher
-- set suffixes=.jpg,.png,.jpeg,.gif,.bak,~,.swp,.swo,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyo

vim.opt.textwidth = 100
-- set a column at position 100
vim.opt.colorcolumn="+1" 

-- Show s/// as you type
vim.opt.icm="nosplit"

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

-- autoread. See https://stackoverflow.com/questions/2490227/how-does-vims-autoread-work
vim.cmd [[
set autoread " neovim default
au FocusGained,BufEnter * :silent! !
au FocusLost,WinLeave * :silent! w
]]

-- Exit terminal with esc
-- tnoremap <esc> <C-\><C-N>

-- Spell
vim.opt.spell = true
vim.opt.spelllang = 'en'
vim.opt.spellsuggest = '6'
vim.cmd [[
  au TermOpen * setlocal nospell
]]

-- Change makeprg to use bear
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"c", "cpp"},
  callback = function()
    vim.opt_local.makeprg = "bear make"
    vim.opt_local.commentstring = "// %s"
  end,
})

