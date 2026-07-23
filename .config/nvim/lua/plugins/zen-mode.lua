return {
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        width = 110,
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
