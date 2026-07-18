return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        -- This explicitly ensures you DON'T see the ghost text of who changed the line
        current_line_blame = false, 
        
        -- Establishes clean, subtle vertical lines for changes in the left gutter
        signs = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        
        -- ADD THIS BLOCK: Style the floating Git windows to match diagnostics
        preview_config = {
          border = 'rounded',   -- Options: 'none', 'single', 'double', 'rounded', 'solid', 'shadow'
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },

        -- Add this section to create your shortcuts
        on_attach = function(bufnr)
          local gs = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- 1. Navigation (Jump between changes)
          -- Pressing ]h goes to the next change, [h goes to the previous
          map('n', ']h', function()
            if vim.wo.diff then return ']h' end
            vim.schedule(function() gs.nav_hunk('next') end)
            return '<Ignore>'
          end, {expr=true, desc = "Next Git Change"})

          map('n', '[h', function()
            if vim.wo.diff then return '[h' end
            vim.schedule(function() gs.nav_hunk('prev') end)
            return '<Ignore>'
          end, {expr=true, desc = "Prev Git Change"})

          -- 2. Actions (Preview, Reset, Blame)
          map('n', '<leader>cs', gs.preview_hunk, { desc = "Preview Git Hunk" })
          map('n', '<leader>cb', function() gs.blame_line{full=true} end, { desc = "Blame Current Line" })
          map('n', '<leader>cr', gs.reset_hunk, { desc = "Reset Git Hunk" })
        end
      })
    end
  },

  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- Renders nice icons next to filenames
    config = function()
      require('diffview').setup({
        enhanced_diff_hl = true, -- Gives you highly readable color highlights for code diffs
      })
    end,
    keys = {
      -- 1. View history of the CURRENT file you are looking at
      { "<leader>fh", "<cmd>DiffviewFileHistory %<cr>", desc = "Current File History" },
      
      -- 2. View history of the ENTIRE project commits
      { "<leader>ch", "<cmd>DiffviewFileHistory<cr>", desc = "Project Commit History" },
      
      -- 3. Close the history panel and return to your code
      { "<leader>fc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
    },
  }
}
