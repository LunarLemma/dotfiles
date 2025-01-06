-- vim options
require("vim.vim_options")
-- vim keymaps
require("vim.keymaps")

-- NOTE: Setup lazy and plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Setup lazy and plugins
require("lazy").setup({
	-- NOTE: Following plugins are user interface imports
	-- "tpope/vim-sleuth", -- auto adjust tabstop and shiftwidth based on file
	require("plugins.gitsigns"), -- add git signs, gutters, blame etc
	-- require("plugins.telescope"), -- fuzzy finder for files, buffers, grep etc
	require("plugins.which-key"),
	require('plugins.fzf'),
	-- NOTE: Following plugins are lsp imports
	require("plugins.lazydev"), -- for lua lsp
	require("plugins.lsp_fzf"),
	{ "Bilal2453/luvit-meta", lazy = true },
	-- NOTE: Autocompletion and stuff
	require("plugins.nvim-cmp"),
	require("plugins.conform"),
	-- NOTE: Extra plugins
	require("plugins.debug"),
	require("plugins.lint"),
	require("plugins.indent_line"),
	require("plugins.neo-tree"),
	require("plugins.autopairs"),
	require("plugins.lazygit"),
	require("plugins.toggleterm"),
	require("plugins.mutli_cursor"),
	require("plugins.ufo-fold"),
	require("plugins.autosession"),
	-- require("plugins.tabs"),
	-- NOTE: UI and quality of life for IDE
	require("interface.lualine"),
	require("interface.bufferline"),
	require("interface.mini"),
	-- require("interface.tokyonight"),
	require('interface.catppuccin'),
	require("interface.nvim-treesitter"),
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
