-- matugen reload

-- reload matugen colors on SIGUSR1 hook
vim.api.nvim_create_autocmd("Signal", {
  pattern  = "SIGUSR1",
  callback = function()
    local path = os.getenv("HOME") .. "/.config/matugen/generated/neovim-colors.lua"
    local f = io.open(path, "r")
    if f then
      io.close(f)
      dofile(path)
    end
  end,
})

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- restore cursor position on file open
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local pos = vim.fn.line("'\"")
    if pos > 0 and pos <= vim.fn.line("$") then
      vim.cmd("normal! g`\"")
    end
  end,
})

-- close specific windows with q
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf", "help", "man", "lspinfo", "checkhealth" },
  callback = function()
    vim.keymap.set("n", "q", ":q<CR>", { buffer = true, silent = true })
  end,
})

-- auto-resize splits on terminal resize
vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})
