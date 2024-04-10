-- :vim ft=lua:
vim.opt.background = "dark"
vim.g.colors_name = "darcula-solid-custom"

local lush = require "lush"
local darcula_solid = require "lush_theme.darcula-solid"
local spec = lush.extends({ darcula_solid }).with(function()
  -- Your modifications go here...
  -- Pallete copied from https://github.com/briones-gabriel/darcula-solid.nvim/blob/main/lua/lush_theme/darcula-solid.lua
  local black = lush.hsl(0, 0, 0)

  return {
    Type { bg = black },
    Function { bg = darcula_solid.Normal.bg },
  }
end)

lush(spec)
