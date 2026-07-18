-- Create an autocommand group for filetype-specific indentation
local indent_group = vim.api.nvim_create_augroup("FileTypeIndent", { clear = true })

-- Helper function to set tab sizes locally for the current buffer
local function set_indent(width)
  vim.opt_local.tabstop = width
  vim.opt_local.softtabstop = width
  vim.opt_local.shiftwidth = width
  vim.opt_local.expandtab = true
end

-- .NET files (C#) -> 4 spaces
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cs" },
  group = indent_group,
  callback = function()
    set_indent(4)
  end,
})

-- HTML and CSS (Optional reminder: these will already inherit your global 2 spaces, 
-- but you can explicitly enforce it here if needed)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "css" },
  group = indent_group,
  callback = function()
    set_indent(2)
  end,
})

