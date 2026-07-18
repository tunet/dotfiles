-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.lazy")
require("config.statuscolumn")
require("config.indents")
require("config.diagnostic")

-- 1. Enable the ruler at column 80
vim.opt.colorcolumn = "81"

-- Always keep at least 5 lines of context above/below the cursor
vim.opt.scrolloff = 15

