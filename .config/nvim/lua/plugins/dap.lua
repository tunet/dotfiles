return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup({
	-- NEW: Anchor the floating control bar to a panel you actually use
        controls = {
          element = "scopes", -- Changes the default from "repl" to "scopes"
          enabled = true,     -- Ensures the button panel renders
        },
        layouts = {
          {
            -- A single layout tray fixed to the bottom of the editor
            elements = {
              { id = "scopes", size = 0.5 }, -- 50% of the screen width for variables
              { id = "stacks", size = 0.5 }, -- 50% of the screen width for the call stack
            },
            position = "bottom",
            size = 12, -- Height of the bottom tray in lines
          },
        },
      })

      -- Automatically toggle the debugging UI panels on execution states
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      -- Point directly to Mason's installation path
      local netcoredbg_path = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg"

      dap.adapters.coreclr = {
        type = "executable",
        command = netcoredbg_path,
        args = { "--interpreter=vscode" }
      }

      -- Run configuration for C# projects
      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = function()
            -- Prompts you for the target compiled assembly path, defaulting to bin/Debug/
            return vim.fn.input("Path to target DLL: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = false,
        },
	-- NEW: The Attach configuration
        {
          type = "coreclr",
          name = "attach - netcoredbg",
          request = "attach",
          processId = require("dap.utils").pick_process,
        },
      }

      -- 1. Create a custom highlight group for the background color
      -- You can change "#2d3748" to any hex color that fits your color scheme
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, bg = "#2d3748", fg = nil })

      -- 2. Redefine the 'DapStopped' sign to use that background highlight group
      vim.fn.sign_define("DapStopped", {
        text = "➔",                -- Change the gutter icon to something crisper
        texthl = "DiagnosticWarn", -- Color of the gutter icon
        linehl = "DapStoppedLine", -- THIS highlights the entire line background!
        numhl = "DiagnosticWarn",  -- Highlights the line number color
      })


      -- Keymaps: Standard IDE-style debugging layouts
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
    end
  }
}

