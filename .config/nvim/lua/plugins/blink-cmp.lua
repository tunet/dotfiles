return {
  {
    'saghen/blink.cmp',
    -- Explicitly pull the pre-built release binary for performance
    version = '*',
    
    opts = {
      -- 'default' keymaps: 
      --   - <C-space> to open the menu
      --   - <CR> (Enter) to accept the suggestion
      --   - <Tab> and <S-Tab> to navigate up and down
      keymap = { preset = 'default' },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },

      -- Instruct blink to pull completions from Neovim's LSP client
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
    -- Allows other plugins (like lspconfig) to read blink's capabilities
    opts_extend = { "sources.default" }
  }
}

