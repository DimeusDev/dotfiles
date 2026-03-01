-- project.nvim
return {
  {
    "ahmedkhalf/project.nvim",
    event  = "VeryLazy",
    config = function()
      require("project_nvim").setup({
        detection_methods = { "pattern", "lsp" },
        patterns          = { ".git", "Makefile", "package.json", "pyproject.toml", ".project" },
        silent_chdir      = true,
        scope_chdir       = "global",
        show_hidden       = false,
      })
    end,
  },
}
