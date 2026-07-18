return {
  "nvim-telescope/telescope-ui-select.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")
    
    telescope.setup({
      extensions = {
        ["ui-select"] = {
          -- Mounts the selection list inside a clean, centered dropdown window
          require("telescope.themes").get_dropdown({}),
        },
      },
    })

    -- Instruct Telescope to hijack the global vim.ui.select system pipeline
    telescope.load_extension("ui-select")
  end,
}

