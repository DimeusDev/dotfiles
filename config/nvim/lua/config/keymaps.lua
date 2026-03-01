-- keymaps
local map = vim.keymap.set

-- window navigation
map("n", "<C-h>", "<C-w>h", { desc = "window left" })
map("n", "<C-j>", "<C-w>j", { desc = "window down" })
map("n", "<C-k>", "<C-w>k", { desc = "window up" })
map("n", "<C-l>", "<C-w>l", { desc = "window right" })

-- window resize
map("n", "<C-Up>",    ":resize -2<CR>",          { silent = true })
map("n", "<C-Down>",  ":resize +2<CR>",          { silent = true })
map("n", "<C-Left>",  ":vertical resize -2<CR>", { silent = true })
map("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true })

-- buffer navigation
map("n", "<S-h>", ":bprevious<CR>", { silent = true, desc = "prev buffer" })
map("n", "<S-l>", ":bnext<CR>",     { silent = true, desc = "next buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "delete buffer" })

-- clear search highlight
map("n", "<Esc>", ":nohl<CR>", { silent = true })

-- save / quit
map("n", "<C-s>", ":w<CR>",  { silent = true, desc = "save" })
map("n", "<C-q>", ":q<CR>",  { silent = true, desc = "quit" })

-- move lines in visual mode
map("v", "<A-j>", ":m .+1<CR>==", { silent = true })
map("v", "<A-k>", ":m .-2<CR>==", { silent = true })
map("x", "<A-j>", ":move '>+1<CR>gv=gv", { silent = true })
map("x", "<A-k>", ":move '<-2<CR>gv=gv", { silent = true })

-- indent and keep selection
map("v", "<", "<gv")
map("v", ">", ">gv")

-- paste without overwriting register
map("v", "p", '"_dP')

-- diagnostics
map("n", "[d", vim.diagnostic.goto_prev, { desc = "prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "next diagnostic" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "diagnostic float" })
