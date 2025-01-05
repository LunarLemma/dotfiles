-- File: lua/plugins/catppuccin.lua
return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false, -- Load immediately
  priority = 1000, -- Load before other plugins
  config = function()
    require("catppuccin").setup({
      flavour = "frappe", -- Set default flavor (latte, frappe, macchiato, mocha)
      transparent_background = false, -- Disable/enable transparent background
      term_colors = true, -- Apply terminal colors
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = { "bold" },
        keywords = { "italic" },
        strings = {},
        variables = {},
      },
      integrations = {
        cmp = true, -- Enable integration with nvim-cmp
        gitsigns = true, -- Enable integration with GitSigns
        nvimtree = true, -- Enable integration with NvimTree
        -- telescope = true, -- Enable integration with Telescope
        treesitter = true, -- Enable integration with Treesitter
        lsp_saga = true,
        lsp_trouble = true,
        -- lualine= true,
        bufferline= true
      },
      custom_highlights = function(colors)
        return {
          Comment = { fg = colors.overlay1, style = { "italic" } },
          Function = { fg = colors.blue, style = { "bold" } },
          Keyword = { fg = colors.mauve, style = { "italic" } },
        }
      end,
    })

    -- Apply the theme
    vim.cmd.colorscheme("catppuccin")
  end,
}
