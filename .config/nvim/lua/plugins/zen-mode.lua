return {
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        width = 120,
        options = {
          wrap = true,
        },
      },
      plugins = {
        options = {
          enabled = true,
          statusline = false,
        },
      },
      on_open = function(win)
        -- Wait a microsecond for the window to settle, then force the statusline active
        vim.schedule(function()
          vim.opt.laststatus = 3
          vim.wo[win].statusline = "%!v:lua.MiniStatusline.active()"
        end)
      end,
    },
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode (Center Code)" }
    }
  },
}
