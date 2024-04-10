return {
  {
    "akinsho/toggleterm.nvim",
    config = function(_, opts)
      opts.size = termSize
      opts.on_create = function(t)
        vim.opt.foldcolumn = "0"
        vim.opt.signcolumn = "no"
        local toggle = function() t:toggle() end
        vim.keymap.set({ "n", "t", "i" }, "<C-'>", toggle, { desc = "Toggle terminal", buffer = t.bufnr })
        vim.keymap.set({ "n", "t", "i" }, "<F7>", toggle, { desc = "Toggle terminal", buffer = t.bufnr })
      end,
      require("toggleterm").setup(opts)
    end,
  },
}
