-- ================================
--   Minimal Neovim init.lua
-- ================================


require("config")
require("plugins")

-- 1. Basic Settings
vim.opt.number = true         -- Show line numbersj
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.shiftwidth = 2        -- Indent by 2 spaces
vim.opt.tabstop = 2           -- 1 tab = 2 spaces
vim.opt.termguicolors = true  -- Better colors
vim.opt.ignorecase = true     -- Case-insensitive search...
vim.opt.smartcase = true      -- ...unless capital letters used
vim.opt.cursorline = true     -- Highlight current line
vim.opt.clipboard = "unnamedplus"
vim.opt.incsearch = true

-- Set undo directory depending on OS
local undodir
if vim.loop.os_uname().sysname == "Windows_NT" then
  undodir = vim.fn.stdpath("data") .. "\\undo"
else
  undodir = vim.fn.stdpath("data") .. "/undo"
end

-- Create undo directory if it doesn't exist
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end

vim.opt.undodir = undodir

vim.lsp.enable({ "luals" })

--  ============= mini.surround ====================
require('mini.surround').setup()
-- ================================================
