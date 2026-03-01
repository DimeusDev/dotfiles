-- tokyonight base
return {
  {
    "folke/tokyonight.nvim",
    lazy     = false,
    priority = 1000,
    opts = {
      style            = "night",
      transparent      = false,
      terminal_colors  = true,
      dim_inactive     = false,
      styles = {
        comments    = { italic = true },
        keywords    = { italic = false },
        functions   = {},
        variables   = {},
        sidebars    = "dark",
        floats      = "dark",
      },
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd("colorscheme tokyonight-night")

      -- apply matugen colors, fallback default tokyo night colors
      local path = os.getenv("HOME") .. "/.config/matugen/generated/neovim-colors.lua"
      local f = io.open(path, "r")
      if f then
        io.close(f)
        dofile(path)
      end
    end,
  },
}
