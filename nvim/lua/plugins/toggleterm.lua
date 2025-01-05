return {
  -- Lazy.nvim plugin setup
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        -- General configuration
        open_mapping = [[<c-\>]],  -- Keybinding to toggle the terminal
        direction = 'float',       -- 'float', 'horizontal', 'vertical', or 'tab'
        size = 20,                 -- Size of the terminal (only relevant for horizontal/vertical)
        -- Floating terminal window settings
        float_opts = {
          border = 'single',  -- Use 'double', 'single', 'shadow', or other border types
          width = 80,         -- Width of floating terminal
          height = 20,        -- Height of floating terminal
        },

        -- Custom keybindings (optional)
        keymaps = {
          toggle_term = '<c-\\>',  -- Custom keybinding to toggle the terminal (already set as default)
          copy_mode = '<c-c>',     -- Keybinding for copy-mode in terminal (e.g. tmux-style copy)
          send_input = '<c-a>',    -- Keybinding to send input to terminal
        },

        -- Hide cursor when terminal is open
        hide_cursor = true,  -- Set true if you want to hide cursor in normal mode

        -- Automatically change window size for better usability
        auto_resize = true,  -- Automatically resize the terminal window when resizing nvim

        -- Terminal behaviour options
        insert_mappings = true,  -- Allow mappings in insert mode within terminal
        persist_mode = true,     -- Keep terminal open even after exiting (requires a terminal emulator like tmux)
      })
    end,
  }
}
