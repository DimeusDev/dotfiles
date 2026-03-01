-- editor plugins: telescope, treesitter, which-key, indent-blankline, colorizer
return {

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd          = "Telescope",
    version      = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
    },
    opts = {
      defaults = {
        prompt_prefix    = "  ",
        selection_caret  = " ",
        sorting_strategy = "ascending",
        border           = true,
        layout_strategy  = "horizontal",
        layout_config    = {
          horizontal = { prompt_position = "top", preview_width = 0.55 },
          width      = 0.87,
          height     = 0.80,
          preview_cutoff = 120,
        },
        file_ignore_patterns = { "node_modules", ".git/" },
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            ["<C-u>"] = false,
            ["<Esc>"] = "close",
          },
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "projects")
    end,
    keys = {
      { "<leader>ff", ":Telescope find_files<CR>",             desc = "find files" },
      { "<leader>fg", ":Telescope live_grep<CR>",              desc = "grep" },
      { "<leader>fb", ":Telescope buffers<CR>",                desc = "buffers" },
      { "<leader>fh", ":Telescope help_tags<CR>",              desc = "help tags" },
      { "<leader>fr", ":Telescope oldfiles<CR>",               desc = "recent files" },
      { "<leader>fs", ":Telescope lsp_document_symbols<CR>", desc = "document symbols" },
      { "<leader>fp", ":Telescope projects<CR>",               desc = "projects" },
      { "<leader>/",  ":Telescope current_buffer_fuzzy_find<CR>", desc = "search buffer" },
    },
  },

  -- syntax highlighting treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "VeryLazy", "BufReadPost", "BufNewFile" },
    opts  = {
      ensure_installed = {
        "bash", "c", "css", "html", "javascript", "json", "jsonc",
        "lua", "luadoc", "markdown", "markdown_inline", "python",
        "regex", "scss", "toml", "typescript", "tsx", "vim", "vimdoc",
        "yaml",
      },
      highlight = { enable = true },
      indent    = { enable = true },
    },
    config = function(_, opts)
      -- new api
      local ok, ts = pcall(require, "nvim-treesitter")
      if ok and type(ts.setup) == "function" then
        ts.setup(opts)
        return
      end
      -- legacy API
      local ok2, configs = pcall(require, "nvim-treesitter.configs")
      if ok2 then
        configs.setup(opts)
      end
    end,
  },

  -- keybind helper
  {
    "folke/which-key.nvim",
    lazy     = false,
    priority = 100,
    opts  = {
      preset   = "modern",
      triggers = {},
      spec     = {
        { "<leader>f", group = "find" },
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code" },
        { "<leader>g", group = "git" },
        { "<leader>t", group = "terminal" },
        { "<leader>w", group = "window" },
      },
    },
    keys = {
      {
        "<leader>k",
        function() require("which-key").show({ global = true }) end,
        desc = "show keymaps",
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main  = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts  = {
      indent = {
        char     = "│",
        tab_char = "│",
      },
      scope  = {
        enabled    = true,
        show_start = false,
        show_end   = false,
      },
      exclude = {
        filetypes = {
          "help", "alpha", "dashboard", "neo-tree",
          "Trouble", "lazy", "mason", "toggleterm",
        },
      },
    },
  },

  -- inline color preview 
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    opts  = {
      user_default_options = {
        RGB      = true,
        RRGGBB   = true,
        names    = false,
        css      = true,
        css_fn   = true,
        mode     = "background",
        tailwind = false,
      },
    },
  },

}
