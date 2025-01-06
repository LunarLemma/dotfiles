-- NOTE: This plugin configures search files in floating mode
return { -- Fuzzy Finder (files, lsp, etc)
	"ibhagwan/fzf-lua",
	event = "VimEnter",
	dependencies = {
		-- Useful for getting pretty icons, but requires a Nerd Font.
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		-- [[ Configure fzf-lua ]]
		-- See `:help fzf-lua` for full documentation.
		local fzf = require("fzf-lua")

		fzf.setup({
			winopts = {
				height = 0.85, -- Window height (percent)
				width = 0.80, -- Window width (percent)
				preview = {
					default = "bat", -- Use 'bat' for syntax highlighting (requires bat installed)
					horizontal = "right:50%", -- Horizontal split for preview
					layout = "horizontal", -- Layout direction
				},
			},
			files = {
				prompt = "Files❯ ",
				cmd = "rg --files --hidden --follow --glob '!.git/*'", -- Use ripgrep
				git_icons = true, -- Show git status icons
				file_icons = true, -- Show file type icons
				color_icons = true, -- Enable color for icons
			},
			grep = {
				prompt = "Rg❯ ",
				cmd = "rg --vimgrep",
				git_icons = true,
				file_icons = true,
				color_icons = true,
			},
			buffers = {
				prompt = "Buffers❯ ",
				show_all_buffers = true,
				sort_lastused = true,
			},
			lsp = {
				prompt = "LSP❯ ",
				async_or_timeout = 5000,
				cwd_only = false,
			},
			keymap = {
				builtin = {
					["<F1>"] = "toggle-preview", -- Toggle preview
					["<F2>"] = "toggle-fullscreen", -- Toggle fullscreen
				},
				fzf = {
					["ctrl-u"] = "unix-line-discard",
					["ctrl-d"] = "half-page-down",
					["ctrl-a"] = "beginning-of-line",
					["ctrl-e"] = "end-of-line",
				},
			},
			fzf_opts = {
				["--layout"] = "reverse",
				["--info"] = "inline",
			},
		})

		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }

		map("n", "<leader>sh", fzf.help_tags, { desc = "[S]earch [H]elp" })
		map("n", "<leader>sk", fzf.keymaps, { desc = "[S]earch [K]eymaps" })
		map("n", "<leader>sf", fzf.files, { desc = "[S]earch [F]iles" })
		map("n", "<leader>ss", fzf.builtin, { desc = "[S]earch [S]elect fzf-lua" })
		map("n", "<leader>sw", fzf.grep_cword, { desc = "[S]earch current [W]ord" })
		map("n", "<leader>sg", fzf.live_grep, { desc = "[S]earch by [G]rep" })
		map("n", "<leader>sd", fzf.diagnostics_workspace, { desc = "[S]earch [D]iagnostics" })
		map("n", "<leader>sr", fzf.resume, { desc = "[S]earch [R]esume" })
		map("n", "<leader>s.", fzf.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		map("n", "<leader><leader>", fzf.buffers, { desc = "[ ] Find existing buffers" })

		-- Additional functionality for in-buffer search
		map("n", "<leader>/", function()
			fzf.grep_curbuf({
				prompt = "Search in current buffer > ",
				search = "", -- Optional: start with an empty query
			})
		end, { desc = "[/] Fuzzily search in current buffer" })
		-- Grep open files only
		map("n", "<leader>s/", function()
			fzf.live_grep({
				grep_open_files = true,
				prompt = "Live Grep in Open Files❯ ",
			})
		end, { desc = "[S]earch [/] in Open Files" })

		-- Shortcut for searching your Neovim configuration files
		map("n", "<leader>sn", function()
			fzf.files({ cwd = vim.fn.stdpath("config"), prompt = "NVIM Config❯ " })
		end, { desc = "[S]earch [N]eovim files" })
	end,
}
