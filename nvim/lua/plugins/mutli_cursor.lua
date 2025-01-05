return {
  "mg979/vim-visual-multi",
  branch = "master",
  lazy = false, -- Load immediately
  config = function()
    -- Advanced settings for vim-visual-multi
    vim.g.VM_theme = "ocean" -- Available themes: default, ocean, iceblue, neongreen, desert
    vim.g.VM_leader = "\\" -- Leader key for Visual Multi commands
    vim.g.VM_highlight_matches = "underline" -- Highlight matches with underline
    vim.g.VM_show_warnings = 1 -- Enable warnings for conflicts
    vim.g.VM_maps = {
      ["Find Under"] = "<C-d>", -- Select word under the cursor
      ["Find Subword Under"] = "<C-d>", -- Select subword under the cursor
      ["Add Cursor Down"] = "<C-j>", -- Add a cursor below the current line
      ["Add Cursor Up"] = "<C-k>", -- Add a cursor above the current line
      ["Skip Region"] = "<C-s>", -- Skip the current match
      ["Remove Last Region"] = "<C-x>", -- Remove the last added cursor
    }

    -- Define a custom mapping for toggling multi-cursor
    vim.api.nvim_set_keymap("n", "<C-m>", ":VMStart<CR>", { noremap = true, silent = true }) -- Start multi-cursor mode
  end,
}
