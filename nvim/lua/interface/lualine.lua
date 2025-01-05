return {
  "nvim-lualine/lualine.nvim",
  lazy = false, -- Load immediately
  config = function()
    require("lualine").setup({
      options = {
        theme = "catppuccin", -- Use Catppuccin theme
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        globalstatus = true, -- Use a single global statusline
        disabled_filetypes = { "NvimTree", "packer" }, -- Disable in specific filetypes
      },
      sections = {
        lualine_a = { "mode" }, -- Shows current mode (e.g., INSERT, NORMAL)
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          {
            "filename",
            path = 1, -- 0: just the filename, 1: relative path, 2: absolute path
            shorting_target = 40, -- Shorten the path if it's longer than 40 characters
            symbols = { modified = "[+]", readonly = "[-]", unnamed = "[No Name]" },
          },
          {
            function()
              return require("lsp-status").status() -- Show LSP status
            end,
            cond = function()
              return #vim.lsp.get_clients() > 0 -- Only show if LSP is active
            end,
          },
        },
        lualine_x = {
          {
            "encoding",
            fmt = string.upper, -- Always show encoding in uppercase
          },
          "fileformat", -- Shows file format (e.g., unix, dos, mac)
          "filetype", -- Shows the filetype (e.g., lua, python)
        },
        lualine_y = {
          {
            "progress", -- Shows progress in the file
            fmt = function(progress)
              return progress .. " 📜" -- Add an emoji for style
            end,
          },
        },
        lualine_z = { "location" }, -- Shows the cursor's location (e.g., 12:45)
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "nvim-tree", "quickfix" }, -- Enable Lualine in NvimTree and Quickfix
    })
  end,
}
