local utils = require "astronvim.utils"
local maps = utils.empty_map_table()
local custom = {
  -- normal mode
  n = {
    ["<leader>"] = { name = "Utilities/Plugins" },

    -- navigate buffer tabs with `H` and `L`
    L = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    H = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },

    -- mappings seen under group name "Buffer"
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },

    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    
    ["["] = { name = "Previous ..." },
    ["]"] = { name = "Next ..." },
    g = { name = "Go ..." },
    z = { name = "Folds/Spelling ..." },

    -- Show Which-Key 
    -- ["<C-/>"] = { "<Cmd>WhichKey<CR>", desc = "Show Which-Key (Keymappings)" },

    ["<leader>th"] = { "<cmd>ToggleTerm direction=horizontal<cr>", desc = "ToggleTerm horizontal split" },
    ["<leader>tv"] = { "<cmd>ToggleTerm direction=vertical<cr>", desc = "ToggleTerm vertical split" },

    ["<a-j>"] = { "<cmd>move .+1<cr>==", desc = "move line(s) down" },
    ["<a-k>"] = { "<cmd>move .-2<cr>==", desc = "move line(s) up" },

    ["<leader>rn"] = { vim.lsp.buf.rename() },
  },
  -- Insert Mode
  i = {
    -- Show Which-Key 
    ["<C-/>"] = { "<Cmd>WhichKey<CR>", desc = "Show Which-Key (Keymappings)" },

    ["<A-j>"] = { "<Esc><cmd>move .+1<cr>==gi" },
    ["<A-k>"] = { "<Esc><cmd>move .-2<cr>==gi" },
  },
  -- Visual Mode
  v = {
    ["<C-/>"] = { "<Cmd>WhichKey<CR>", desc = "Show Which-Key (Keymappings)" },
    -- Show Which-Key 

    ["<S-Tab>"] = { "<gv", desc = "Unindent line" },
    ["<Tab>"] = { ">gv", desc = "Indent line" },
    ["<"] = { "<gv", desc = "Unindent line" },
    [">"] = { ">gv", desc = "Indent line" },

    -- https://vim.fandom.com/wiki/Moving_lines_up_or_down#Mappings_to_move_lines
    ["<A-k>"] = { "<cmd>'<,'>move '>-2<cr>gv=gv", desc = "Move line(s) up" },
    ["<A-j>"] = { "<cmd>'<,'>move '<+1<cr>gv=gv", desc = "Move line(s) down" },
  },
  -- Terminal Mode
  t = {
    ["<S-ESC>"] = { [[<C-\><C-n>]], desc="Switch to Normal Mode"  },
    ["<C-h>"] = {[[<Cmd>wincmd h<CR>]] },
    ["<C-j>"] = {[[<Cmd>wincmd j<CR>]] },
    ["<C-k>"] = {[[<Cmd>wincmd k<CR>]] },
    ["<C-l>"] = {[[<Cmd>wincmd l<CR>]] },
    ["<C-w>"] = {[[<C-\><C-n><C-w>]] },
  },
}

maps = vim.tbl_deep_extend("force", maps, custom)

-- Smart Splits
if utils.is_available "smart-splits.nvim" then
  maps.n["<C-h>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" }
  maps.n["<C-j>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" }
  maps.n["<C-k>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" }
  maps.n["<C-l>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" }
  maps.n["<S-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" }
  maps.n["<S-Down>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" }
  maps.n["<S-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" }
  maps.n["<S-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" }
else
  maps.n["<C-h>"] = { "<C-w>h", desc = "Move to left split" }
  maps.n["<C-j>"] = { "<C-w>j", desc = "Move to below split" }
  maps.n["<C-k>"] = { "<C-w>k", desc = "Move to above split" }
  maps.n["<C-l>"] = { "<C-w>l", desc = "Move to right split" }
  maps.n["<S-Up>"] = { "<cmd>resize -2<CR>", desc = "Resize split up" }
  maps.n["<S-Down>"] = { "<cmd>resize +2<CR>", desc = "Resize split down" }
  maps.n["<S-Left>"] = { "<cmd>vertical resize -2<CR>", desc = "Resize split left" }
  maps.n["<S-Right>"] = { "<cmd>vertical resize +2<CR>", desc = "Resize split right" }
end

return maps
