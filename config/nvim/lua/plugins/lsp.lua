-- lsp: mason + mason-lspconfig + vim.lsp.config
return {

  -- lsp server installer ui
  {
    "williamboman/mason.nvim",
    cmd   = "Mason",
    build = ":MasonUpdate",
    opts  = {
      ui = {
        border = "rounded",
        icons  = {
          package_installed   = "v",
          package_pending     = ">",
          package_uninstalled = "x",
        },
      },
    },
  },

  -- default server config
  {
    "neovim/nvim-lspconfig",
    event        = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- diagnostic display
      vim.diagnostic.config({
        severity_sort    = true,
        update_in_insert = false,
        underline        = true,
        signs            = true,
        virtual_text     = { prefix = "●", spacing = 4 },
        float = {
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      local on_attach = function(_, buf)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = buf, desc = desc })
        end
        map("gd",         vim.lsp.buf.definition,     "goto definition")
        map("gD",         vim.lsp.buf.declaration,    "goto declaration")
        map("gr",         vim.lsp.buf.references,     "references")
        map("gI",         vim.lsp.buf.implementation, "goto implementation")
        map("K",          vim.lsp.buf.hover,          "hover docs")
        map("<leader>ca", vim.lsp.buf.code_action,    "code action")
        map("<leader>rn", vim.lsp.buf.rename,         "rename symbol")
        map("<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "format")
        map("<leader>ci", vim.lsp.buf.incoming_calls, "incoming calls")
        map("<leader>co", vim.lsp.buf.outgoing_calls, "outgoing calls")
      end

      -- global defaults applied to every server
      vim.lsp.config("*", {
        capabilities = capabilities,
        on_attach    = on_attach,
      })

      -- lua: suppress vim global warning
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace   = { checkThirdParty = false },
            telemetry   = { enable = false },
          },
        },
      })
    end,
  },

  -- bridge: mason install paths -> vim.lsp.enable()
  {
    "williamboman/mason-lspconfig.nvim",
    event        = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "lua_ls",
        "bashls",
        "pyright",
        "ts_ls",
        "html",
        "cssls",
        "jsonls",
      },
      automatic_enable = true,  -- calls vim.lsp.enable() for each installed server
    },
  },

  -- formatters and linters via none-ls
  {
    "nvimtools/none-ls.nvim",
    event        = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        border  = "rounded",
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier.with({
            filetypes = {
              "javascript", "typescript", "css", "scss", "html",
              "json", "yaml", "markdown",
            },
          }),
          null_ls.builtins.formatting.black,
          null_ls.builtins.diagnostics.shellcheck,
        },
      })
    end,
  },

  -- bridge: mason -> none-ls auto-install formatters
  {
    "jay-babu/mason-null-ls.nvim",
    event        = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim" },
    opts = {
      ensure_installed       = { "stylua", "prettier", "black", "shellcheck" },
      automatic_installation = true,
    },
  },

}
