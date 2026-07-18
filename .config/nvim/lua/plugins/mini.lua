return {
    {
        'echasnovski/mini.nvim',
        config = function()
            local statusline = require 'mini.statusline'
            statusline.setup { 
                use_icons = true,
                set_vim_settings = false, -- Stops mini from forcing laststatus = 2
            }
            vim.opt.laststatus = 3 -- Force Neovim to use a single global status bar
        end
    }
}
