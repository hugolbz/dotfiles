-- If nvim-qt, call ginit.vim
vim.api.nvim_create_autocmd( "UIEnter", {
    once = true,
    -- callback = function() require "ginit" end -- for ginit.lua instead
    callback = function() 
      vim.cmd('source $HOME/.config/nvim/lua/custom/ginit.vim')
    end,
  } )

-- Change default leader
vim.g.mapleader = ","
-- vim.api.nvim_set_keymap("n", " ", ",") -- does not seem to work ?!

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
vim.opt.wildignore:append "**/build/*"
vim.opt.wildignore:append "**/.git/*"
vim.opt.wildignore:append "**/doc/doxygen/*"

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
-- vim.opt.colorcolumn=+1 -- Breaks the reading of ginit.vim !!??
-- highlight ColorColumn ctermbg=0 guibg=lightgrey

-- Show s/// as you type
vim.opt.icm=nosplit

-- Folding
-- vim.opt.foldlevel=20 -- reset the mapleader!! Bug
-- vim.opt.foldmethod=expr
-- vim.opt.foldexpr=nvim_treesitter#foldexpr()

-- autoread. See https://stackoverflow.com/questions/2490227/how-does-vims-autoread-work
-- set autoread " neovim default
-- au FocusGained,BufEnter * :silent! !
-- au FocusLost,WinLeave * :silent! w

-- Exit terminal with esc
-- tnoremap <esc> <C-\><C-N>

-- Spell
vim.opt.spell = true
vim.opt.spelllang = 'en'
vim.opt.spellsuggest = 6
vim.cmd [[
  au TermOpen * setlocal nospell
]]

