return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  opts = function(_, opts)
    local utils = require "astronvim.utils"
    local defaults = require "neo-tree.defaults"
    local astro_neotree = require "plugins.neo-tree"
    astro_opts = astro_neotree.opts()

    user_opts = {
      -- close_if_last_window = true,
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        },
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
          --               -- the current file is changed while the tree is open.
          leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
      },
    }

    return vim.tbl_deep_extend("keep", user_opts, astro_opts, defaults)
    
  end,
  config = true
}
