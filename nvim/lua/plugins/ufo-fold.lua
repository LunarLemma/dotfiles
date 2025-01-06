return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      "neovim/nvim-lspconfig", -- For LSP integration
    },
    config = function()
      -- Configure nvim-ufo
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          -- Use LSP if available, fallback to treesitter or indent
          return { "lsp", "indent" }
        end,
      })

      -- Keybindings for folding
      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
      vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "Reduce fold level" })
      vim.keymap.set("n", "zm", require("ufo").closeFoldsWith, { desc = "Increase fold level" })

      -- Set up fold settings
      vim.o.foldcolumn = "1" -- Show fold column
      vim.o.foldlevel = 99   -- Ensure folds are open by default
      vim.o.foldlevelstart = 99 -- Start with all folds open
      vim.o.foldenable = true -- Enable folding
    end,
  },
}
