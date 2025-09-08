-- ================================
--   Minimal Neovim init.lua
-- ================================

-- 1. Basic Settings
vim.opt.number = true          -- Show line numbersj
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
    },
    {"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"},

    { 'nvim-mini/mini.surround', version = false },
    {
      'jinh0/eyeliner.nvim',
      config = function()
        require'eyeliner'.setup {
          -- show highlights only after keypress
          highlight_on_key = true,

          -- dim all other characters if set to true (recommended!)
          dim = false,             

          -- set the maximum number of characters eyeliner.nvim will check from
          -- your current cursor position; this is useful if you are dealing with
          -- large files: see https://github.com/jinh0/eyeliner.nvim/issues/41
          max_length = 9999,

          -- filetypes for which eyeliner should be disabled;
          -- e.g., to disable on help files:
          -- disabled_filetypes = {"help"}
          disabled_filetypes = {},

          -- buftypes for which eyeliner should be disabled
          -- e.g., disabled_buftypes = {"nofile"}
          disabled_buftypes = {},

          -- add eyeliner to f/F/t/T keymaps;
          -- see section on advanced configuration for more information
          default_keymaps = true,
        }
      end
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})


-- ==================== TELESCOPE PLUGIN CONFIG ===========================
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- ========================================================================

-- ============= TREESitter Config ============
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" , "javascript"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,





  -- List of parsers to ignore installing (or "all")
  ignore_install = { },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
-- ===========================================



--  ============= mini.surround ====================
require('mini.surround').setup()
-- =================================================
