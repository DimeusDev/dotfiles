-- editor options
local o = vim.opt

o.number         = true
o.relativenumber = true
o.signcolumn     = "yes"
o.cursorline     = true
o.termguicolors  = true
o.scrolloff      = 8
o.sidescrolloff  = 8
o.wrap           = false
o.expandtab      = true
o.shiftwidth     = 2
o.tabstop        = 2
o.smartindent    = true
o.ignorecase     = true
o.smartcase      = true
o.incsearch      = true
o.hlsearch       = true
o.pumheight      = 10
o.splitbelow     = true
o.splitright     = true
o.updatetime     = 200
o.undofile       = true
o.clipboard      = "unnamedplus"
o.cmdheight      = 0      -- hide cmdline when idle
o.laststatus     = 3      -- global statusline
o.showmode       = false  -- lualine shows mode
o.showtabline    = 2      -- always show bufferline
o.completeopt    = { "menu", "menuone", "noselect" }
o.conceallevel   = 0
o.fileencoding   = "utf-8"
o.mouse          = "a"
o.timeoutlen     = 500

o.fillchars = {
  fold      = " ",
  foldopen  = "v",
  foldclose = ">",
  foldsep   = " ",
  diff      = "/",
  eob       = " ",
}
