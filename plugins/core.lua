local termSize = function(term)
        if term.direction == "horizontal" then
          return vim.o.lines * 0.25
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.5
        else
          return 80
        end
      end
return {
  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },
  -- You can disable default plugins as follows:
  -- { "max397574/better-escape.nvim", enabled = false },
  --
  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  -- {
  --   "L3MON4D3/LuaSnip",
  --   config = function(plugin, opts)
  --     require "plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom luasnip configuration such as filetype extend or custom snippets
  --     local luasnip = require "luasnip"
  --     luasnip.filetype_extend("javascript", { "javascriptreact" })
  --   end,
  -- },
  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"

      -- remove add single quote on filetype scheme or lisp
      npairs.get_rules("'")[1].not_filetypes = { "scheme", "lisp" }
      npairs.get_rules("'")[1]:with_pair(cond.not_after_text("["))

      -- Disable [] pairs for ANSI escape codes
      npairs.get_rules("[")[1]:with_pair(cond.not_before_regex("\\e", 2))
      npairs.get_rules("[")[1]:with_pair(cond.not_after_regex("\\e", 2))
      npairs.remove_rule("[")
      -- sqb:with_pair(cond.not_before_text "\\e")
      -- sqb:with_pair(cond.not_before_regex "\\e")
      -- sqb:with_pair(cond.not_after_regex "\\e")
      -- Keep ] bracket on delete
      -- sqb:with_del(cond.none())

      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- Disable [] pairs for ANSI escape codes
        Rule("[", "]")
          :with_pair(cond.not_after_text "\\e")
          :with_pair(cond.not_inside_quote()),
        Rule("$'\\e", "[m'")
      )
    end,
  },
  -- By adding to the which-key config and using our helper function you can add more which-key registered bindings
  {
    "L3MON4D3/LuaSnip",
    enabled = false,
    version = "v2.*",
    build = "make install_jsregexp",
    config = function(plugin, opts)
     
    end,
  },
  {
    "folke/which-key.nvim",
    config = function(plugin, opts)
      require "plugins.configs.which-key"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- Add bindings which show up as group name
      local wk = require "which-key"
      wk.register({
        b = { name = "Buffer" },
      }, { mode = "n", prefix = "<leader>" })
    end,
  },
}
