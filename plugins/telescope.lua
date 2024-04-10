return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable "make" == 1, build = "make" },
    { "MunifTanjim/nui.nvim" },
  },
  cmd = "Telescope",
  opts = function(_, opts)
    local telescope = require "telescope"
    local defaults = require "telescope.config"
    local astro_opts = require("plugins.telescope").opts()
    --
    -- Clone the default Telescope configuration
    local vimgrep_arguments = { unpack(defaults.values.vimgrep_arguments) }

    -- I want to search in hidden/dot files.
    table.insert(vimgrep_arguments, "--hidden")
    -- I don't want to search in the `.git` directory.
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")
 
    local user_opts = {
    	defaults = {
		-- `hidden = true` is not supported in text grep commands.
		vimgrep_arguments = vimgrep_arguments,
	},  
	    pickers = {
        find_files = {
          find_command = { "fd", "--type=file", "--type=symlink", "--unrestricted", "--follow", "--strip-cwd-prefix", "--glob" },
        }
      },
    }

    return vim.tbl_deep_extend("keep", user_opts, astro_opts, defaults)

    -- local actions = require "telescope.actions"
    -- local get_icon = require("astronvim.utils").get_icon
    -- return {
    --   defaults = {
    --     git_worktrees = vim.g.git_worktrees,
    --     prompt_prefix = get_icon("Selected", 1),
    --     selection_caret = get_icon("Selected", 1),
    --     path_display = { "truncate" },
    --     sorting_strategy = "ascending",
    --     layout_config = {
    --       horizontal = { prompt_position = "top", preview_width = 0.55 },
    --       vertical = { mirror = false },
    --       width = 0.90,
    --       height = 0.90,
    --       preview_cutoff = 120,
    --     },
    --     mappings = {
    --       i = {
    --         ["<C-n>"] = actions.cycle_history_next,
    --         ["<C-p>"] = actions.cycle_history_prev,
    --         ["<C-j>"] = actions.move_selection_next,
    --         ["<C-k>"] = actions.move_selection_previous,
    --       },
    --       n = { q = actions.close },
    --     },
    --   },
    -- }
  end,
  config = require "plugins.configs.telescope",
}
