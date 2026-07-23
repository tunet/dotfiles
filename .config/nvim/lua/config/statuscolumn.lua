-- Helper function to format our two-column line numbers
_G.my_statuscolumn = function()
  local lnum = vim.v.lnum
  local relnum = vim.v.relnum
  
  -- Left column: Absolute line number (padded to 3 spaces)
  local abs_str = string.format("%3d", lnum)
  
  -- Right column: Relative line number (padded to 2 spaces). 
  -- We leave it blank for the current cursor line to avoid duplicate numbers.
  local rel_str = relnum == 0 and "  " or string.format("%2d", relnum)
  
  -- Combine them: %s is the Sign column (Git signs, diagnostics, etc.)
  -- Then our absolute number, a small separator, and our relative number
  return "%s " .. abs_str .. " │ " .. rel_str .. " "
end

vim.opt.number = true
vim.opt.relativenumber = true
-- vim.opt.statuscolumn = "%!v:lua.my_statuscolumn()"

-- %s = Sign column (Git, diagnostics)
-- %= = Right-align the line numbers
-- %l = Native line number (handles the hybrid relative/absolute logic automatically)
vim.opt.statuscolumn = "%s %= %l "
