return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate", -- Automatically updates the registry when the plugin updates
  config = function()
    require("mason").setup({
      ui = {
        border = "rounded", -- Gives the Mason UI a clean visual border
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })
  end
}

