require "nvchad.options"

if vim.g.neovide then
    vim.g.neovide_scroll_animation_length = 0.1
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_cursor_animate_command_line = false
    vim.g.neovide_cursor_animate_in_insert_mode = false
end

vim.o.shell = "/bin/bash"

vim.opt.breakindent = true --Enable break indent
vim.opt.ignorecase = true  --Case insensitive searching unless /C or capital in search

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
vim.opt.diffopt = "internal,filler,closeoff,indent-heuristic,linematch:60,algorithm:histogram"

-- Avertissement par flash (visual bell) plutôt que par beep
vim.opt.visualbell = true
--
-- Suffixes a cacher
-- set suffixes=.jpg,.png,.jpeg,.gif,.bak,~,.swp,.swo,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyo

vim.opt.textwidth = 100
-- set a column at position 100
vim.opt.colorcolumn = "+1"

-- Show s/// as you type
vim.opt.icm = "nosplit"

-- Exit terminal with esc
-- tnoremap <esc> <C-\><C-N>

-- Spell
vim.opt.spell = true
vim.opt.spelllang = 'en'
vim.opt.spellsuggest = '6'
vim.cmd [[
  au TermOpen * setlocal nospell
]]
