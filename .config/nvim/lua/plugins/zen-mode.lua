return {
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        width = 120,
        options = {
          wrap = true,
	  laststatus = 3,
        },
      },
    },
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode (Center Code)" }
    }
  },
}
