-- mapleader must be set before any plugin loads
vim.g.mapleader      = " "
vim.g.maplocalleader = "\\"

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
