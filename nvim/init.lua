-- ================================
--   Minimal Neovim init.lua
-- ================================

-- 1. Basic Settings
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = true  -- Relative line numbers
vim.opt.expandtab = true       -- Use spaces instead of tabs
vim.opt.shiftwidth = 2         -- Indent by 2 spaces
vim.opt.tabstop = 2            -- 1 tab = 2 spaces
vim.opt.termguicolors = true   -- Better colors
vim.opt.ignorecase = true      -- Case-insensitive search...
vim.opt.smartcase = true       -- ...unless capital letters used
vim.opt.cursorline = true      -- Highlight current line


-- Key mapping
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })



-- ====================================
--     Lazy.nvim package manager
-- ====================================
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
      "catppuccin/nvim",
      name = "catppuccin", -- optional, for clarity
      priority = 1000,     -- load before all other start plugins
      config = function()
        require("catppuccin").setup({
          flavour = "mocha", -- latte, frappe, macchiato, mocha
          term_colors = true,
          integrations = {
            treesitter = true,
            telescope = true,
            lualine = true,
          },
        })
        vim.cmd.colorscheme("catppuccin")
      end,
    },

    {
      'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
