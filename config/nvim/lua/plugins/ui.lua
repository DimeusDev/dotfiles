-- ui plugins: bufferline, lualine (bubbly), neo-tree, gitsigns, scrollbar
-- pill separators 
local pill_l = string.char(0xee, 0x82, 0xb6) -- U+E0B6 nerd font left half-circle
local pill_r = string.char(0xee, 0x82, 0xb4) -- U+E0B4 nerd font right half-circle

return {

  -- vscode-style top tab bar
  {
    "akinsho/bufferline.nvim",
    event        = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        mode                 = "buffers",
        separator_style      = "thin",
        always_show_bufferline = true,
        show_buffer_close_icons = true,
        show_close_icon      = false,
        color_icons          = true,
        diagnostics          = "nvim_lsp",
        diagnostics_indicator = function(_, _, diag)
          local icons = { error = " ", warning = " ", hint = "󰠠 ", info = " " }
          local parts = {}
          for name, icon in pairs(icons) do
            if (diag[name] or 0) > 0 then
              parts[#parts + 1] = icon .. diag[name]
            end
          end
          return table.concat(parts, " ")
        end,
        offsets = {
          {
            filetype   = "neo-tree",
            text       = "Explorer",
            text_align = "center",
            separator  = true,
          },
        },
      },
    },
  },

  -- island lualine
  {
    "nvim-lualine/lualine.nvim",
    event        = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      local function build_setup()
        local m      = vim.g.matugen_colors or {}
        local bg_dark  = m.bg_dark   or "#16161e"
        local fg       = m.fg        or "#c0caf5"
        local fg_dim   = m.border    or "#414868"
        local primary  = m.primary   or "#7aa2f7"
        local second   = m.secondary or "#bb9af7"
        local tertiary = m.tertiary  or "#2ac3de"
        local error    = m.error     or "#f7768e"

        local function make_theme(pill_bg)
          return {
            a = { fg = bg_dark, bg = pill_bg, gui = "bold" },
            b = { fg = fg,      bg = bg_dark },
            c = { fg = fg_dim,  bg = bg_dark },
          }
        end

        local theme = {
          normal   = make_theme(primary),
          insert   = make_theme(tertiary),
          visual   = make_theme(second),
          replace  = make_theme(error),
          command  = make_theme(second),
          inactive = {
            a = { fg = fg_dim, bg = bg_dark },
            b = { fg = fg_dim, bg = bg_dark },
            c = { fg = fg_dim, bg = bg_dark },
          },
        }

        return {
          options = {
            theme                = theme,
            -- no section-level separators
            section_separators   = "",
            component_separators = "",
            globalstatus         = true,
            disabled_filetypes   = { statusline = { "neo-tree" } },
          },
          sections = {
            -- isolated pill on the far left
            lualine_a = {
              {
                "mode",
                separator = { left = pill_l, right = pill_r },
                padding   = { left = 1, right = 1 },
              },
            },
            -- flat content
            lualine_b = {
              { "branch", padding = { left = 2, right = 1 } },
              { "diff",
                symbols = { added = "+", modified = "~", removed = "-" },
                padding = { left = 1, right = 2 },
              },
            },
            -- filename center-left
            lualine_c = {
              {
                "filename",
                path      = 1,
                symbols   = { modified = " ●", readonly = " ", unnamed = "[no name]" },
                padding   = { left = 2, right = 1 },
              },
              {
                "diagnostics",
                symbols  = { error = " ", warn = " ", hint = "󰠠 ", info = " " },
                padding  = { left = 1, right = 2 },
              },
            },
            -- flat content
            lualine_x = {
              {
                "filetype",
                padding = { left = 2, right = 1 },
              },
            },
            lualine_y = {
              {
                "progress",
                padding = { left = 1, right = 1 },
              },
            },
            -- isolated pill on the far right
            lualine_z = {
              {
                "location",
                separator = { left = pill_l, right = pill_r },
                padding   = { left = 1, right = 1 },
              },
            },
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { { "filename", padding = { left = 2 } } },
            lualine_x = { { "location", padding = { right = 2 } } },
            lualine_y = {},
            lualine_z = {},
          },
          extensions = { "neo-tree", "toggleterm", "lazy", "mason" },
        }
      end

      local function lualine_apply()
        require("lualine").setup(build_setup())
      end

      -- expose for matugen reload
      _G._matugen_rebuild_lualine = lualine_apply
      lualine_apply()
    end,
  },

  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch       = "v3.x",
    lazy         = false,
    priority     = 900,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          -- auto-open when entering a directory or no args
          if vim.fn.argc() == 0
            or (vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1)
          then
            vim.schedule(function()
              require("neo-tree.command").execute({
                action   = "show",
                source   = "filesystem",
                position = "left",
              })
            end)
          end
        end,
      })
    end,
    opts = {
      close_if_last_window  = false,
      popup_border_style    = "rounded",
      enable_git_status     = true,
      enable_diagnostics    = true,
      open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
      window = {
        position = "left",
        width    = 30,
        mapping_options = { noremap = true, nowait = true },
        mappings = {
          ["<space>"] = "toggle_node",
          ["<cr>"]    = "open",
          ["l"]       = "open",
          ["h"]       = "close_node",
          ["a"]       = "add",
          ["d"]       = "delete",
          ["r"]       = "rename",
          ["y"]       = "copy_to_clipboard",
          ["x"]       = "cut_to_clipboard",
          ["p"]       = "paste_from_clipboard",
          ["?"]       = "show_help",
        },
      },
      filesystem = {
        follow_current_file       = { enabled = true },
        use_libuv_file_watcher    = true,
        hijack_netrw_behavior     = "open_default",
        filtered_items = {
          hide_dotfiles          = false,
          hide_gitignored        = true,
          hide_by_name           = { ".git" },
        },
      },
      default_component_configs = {
        indent = {
          indent_size      = 2,
          expander_collapsed = "",
          expander_expanded  = "",
        },
        icon = {
          folder_closed = "",
          folder_open   = "",
          folder_empty  = "",
        },
        git_status = {
          symbols = {
            added      = "",
            modified   = "",
            deleted    = "x",
            renamed    = "r",
            untracked  = "u",
            ignored    = "i",
            unstaged   = "u",
            staged     = "s",
            conflict   = "!",
          },
        },
      },
    },
    keys = {
      { "<leader>e", ":Neotree toggle<CR>", desc = "toggle file tree", silent = true },
      { "<leader>o", ":Neotree reveal<CR>", desc = "reveal in tree",   silent = true },
    },
  },

  -- git signs in gutter
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts  = {
      signs = {
        add          = { text = "+" },
        change       = { text = "~" },
        delete       = { text = "_" },
        topdelete    = { text = "-" },
        changedelete = { text = "~" },
        untracked    = { text = "?" },
      },
      on_attach = function(buf)
        local gs  = package.loaded.gitsigns
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buf, desc = desc })
        end
        map("n", "]g", gs.next_hunk,  "next hunk")
        map("n", "[g", gs.prev_hunk,  "prev hunk")
        map("n", "<leader>gp", gs.preview_hunk, "preview hunk")
        map("n", "<leader>gr", gs.reset_hunk,   "reset hunk")
        map("n", "<leader>gs", gs.stage_hunk,   "stage hunk")
        map("n", "<leader>gb", gs.blame_line,   "blame line")
      end,
    },
  },

  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },
}
