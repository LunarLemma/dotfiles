return {
  {
    "rmagatti/auto-session",
    opts = {
      log_level = "warn",
      auto_save_enabled = true,
      auto_restore_enabled = true,
      auto_session_suppress_dirs = { "~/", "/" },
      session_lens = nil, -- Enable telescope integration
    },
    config = function(_, opts)
      require("auto-session").setup(opts)
    end,
  },
  {
    "rmagatti/session-lens",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("session-lens").setup({})
    end,
    keys = {
      { "<leader>sf", "<cmd>SearchSession<CR>", desc = "Search sessions" },
    },
  },
}
