return {
  "akinsho/bufferline.nvim",
  lazy = false, -- Load immediately
  dependencies = "nvim-tree/nvim-web-devicons", -- Icons for Bufferline
  config = function()
    require("bufferline").setup({
      options = {
        numbers = "none", -- No buffer numbers; options: "none", "ordinal", "buffer_id"
        diagnostics = "nvim_lsp", -- Show LSP diagnostics in the bufferline
        separator_style = "slant", -- Separator style: "slant", "thick", "thin"
        offsets = {
          { filetype = "NvimTree", text = "File Explorer", text_align = "center" },
        },
        show_buffer_close_icons = true,
        show_close_icon = true,
        always_show_bufferline = true,
      },
      highlights = require("catppuccin.groups.integrations.bufferline").get(),
    })
  end,
}
