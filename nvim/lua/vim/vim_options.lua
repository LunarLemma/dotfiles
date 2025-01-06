-- NOTE: This section contains vim related settings configured via vim api
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true -- Set to false if terminal doesn't support nerd font
-- opts api from vim, see :help option-list
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.showmode = false -- Visible in status bar

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus" -- asynchronously sync clipboard between os and neovim
end)
vim.opt.breakindent = true -- enable break indent
vim.opt.undofile = true --save undo history
vim.opt.ignorecase = true -- ignorecase while searching
vim.opt.signcolumn = "yes"

-- Time sequences
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

-- render how whitespaces are rendered
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.inccommand = "split" -- preview subtitutions live
vim.opt.cursorline = true -- show on which line curson is at

vim.opt.scrolloff = 10

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop= 4

vim.o.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,localoptions"
