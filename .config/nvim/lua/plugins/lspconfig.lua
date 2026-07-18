return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- 1. Establish your snippet and autocomplete capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- (Optional) If you use nvim-cmp, merge its default capabilities:
      local has_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if has_cmp then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end



      -- 2. Define the server configuration using the new native API
      -- This modifies/extends the default configuration provided by the plugin
      vim.lsp.config("cssls", {
        capabilities = capabilities,
      })

      -- 3. Explicitly enable the server
      -- This auto-activates cssls for its designated filetypes (CSS, SCSS, Less)
      vim.lsp.enable("cssls")


      -- --- C# / .NET SETUP ---
      -- 2. Define the server configuration using the new native API
      vim.lsp.config("roslyn_ls", {
        capabilities = capabilities,
        -- The native Microsoft server requires a solution/open handshake on startup.
        -- This function looks upward from your file to find your .sln or .slnx file.
        on_init = function(client)
          local root = client.workspace_folders and client.workspace_folders[1] and client.workspace_folders[1].name or vim.fn.getcwd()
          local sln = vim.fs.find(function(name)
            return name:match("%.slnx?$")
          end, { path = root, upward = true })[1]

          if sln then
            client:notify("solution/open", { solution = vim.uri_from_fname(sln) })
          end
        end,
      })

      -- 3. Explicitly enable the native C# server
      vim.lsp.enable("roslyn_ls")





      -- Global LSP Mappings (Native Neovim bindings)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to Definition" })

      -- Show all references/method calls under the cursor
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "LSP: [G]oto [R]eferences" })

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Hover Documentation" })

      -- Quickfix navigation shortcuts
      vim.keymap.set("n", "[c", ":cprevious<CR>", { silent = true, desc = "Previous reference" })
      vim.keymap.set("n", "]c", ":cnext<CR>", { silent = true, desc = "Next reference" })
    end,
  },
}

