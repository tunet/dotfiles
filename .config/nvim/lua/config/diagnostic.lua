-- Add a clean border to the diagnostic float window
vim.diagnostic.config({
  float = {
    border = "rounded",       -- Options: "none", "single", "double", "rounded", "solid", "shadow"
    focusable = false,        -- Prevents your cursor from accidentally jumping inside it
    source = "always",        -- Shows the source of the diagnostic (e.g., "cssls")
    header = { "Diagnostic Details", "DiagnosticHeader" }, -- Custom header text + highlight group
    prefix = " ",             -- Prefix attached to each diagnostic line
  },
})

-- Press 'gl' (Go to Line diagnostic) to see the error/warning details
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = "Show line diagnostics" })

