-- toggleterm
return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys    = {
      { [[<C-\>]],    desc = "toggle float terminal" },
      { "<leader>tf", desc = "float terminal" },
      { "<leader>th", desc = "horizontal terminal" },
      { "<leader>tv", desc = "vertical terminal" },
    },
    opts = {
      size = function(term)
        if     term.direction == "horizontal" then return 15
        elseif term.direction == "vertical"   then return math.floor(vim.o.columns * 0.4)
        end
      end,
      open_mapping  = [[<C-\>]],
      direction     = "float",
      shade_terminals = false,
      persist_mode  = true,
      float_opts    = {
        border = "curved",
        width  = function() return math.floor(vim.o.columns * 0.85) end,
        height = function() return math.floor(vim.o.lines   * 0.85) end,
      },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      local map = vim.keymap.set
      map("n", "<leader>tf", ":ToggleTerm direction=float<CR>",      { desc = "float terminal",      silent = true })
      map("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", { desc = "horizontal terminal", silent = true })
      map("n", "<leader>tv", ":ToggleTerm direction=vertical<CR>",   { desc = "vertical terminal",   silent = true })

      -- window nav inside terminal mode
      map("t", "<Esc>",  [[<C-\><C-n>]],           { silent = true })
      map("t", "<C-h>",  [[<C-\><C-n><C-w>h]],     { silent = true })
      map("t", "<C-j>",  [[<C-\><C-n><C-w>j]],     { silent = true })
      map("t", "<C-k>",  [[<C-\><C-n><C-w>k]],     { silent = true })
      map("t", "<C-l>",  [[<C-\><C-n><C-w>l]],     { silent = true })
    end,
  },
}
