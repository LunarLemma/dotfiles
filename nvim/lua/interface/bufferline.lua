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

    -- Keymaps for Bufferline
    -- vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "Go to the next buffer", { noremap = true, silent = true, desc = "" } })
    -- vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = "Go to the previous buffer", { noremap = true, silent = true, desc = "" } })
    -- vim.keymap.set("n", "<Leader>bp", ":BufferLinePick<CR>", { desc = "Pick a buffer to switch", { noremap = true, silent = true, desc = "" } })
    -- vim.keymap.set("n", "<Leader>bc", ":BufferLinePickClose<CR>", { desc = "Pick a buffer to close", { noremap = true, silent = true, desc = "" } })
    -- vim.keymap.set("n", "<Leader>bl", ":BufferLineCloseLeft<CR>", { desc = "Close buffers to the left", { noremap = true, silent = true, desc = "" } })
    -- vim.keymap.set("n", "<Leader>br", ":BufferLineCloseRight<CR>", { desc = "Close buffers to the right", { noremap = true, silent = true, desc = "" } })
    -- vim.keymap.set("n", "<Leader>bm", ":BufferLineMoveNext<CR>", { desc = "Move buffer to the right", { noremap = true, silent = true, desc = "" } })
    -- vim.keymap.set("n", "<Leader>bM", ":BufferLineMovePrev<CR>", { desc = "Move buffer to the left", { noremap = true, silent = true, desc = "" } })
  end,
}
