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
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


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
          custom_highlights = function(colors)
            return {
              LineNr = { fg = colors.subtext1 },                 -- relative numbers
              CursorLineNr = { fg = colors.mauve, bold = true }, -- current line number
            }
          end,
        })
        vim.cmd.colorscheme("catppuccin")
      end,
    },
    require("plugins.autocomplete"),
    -- require("plugins.precognition"),
    require("plugins.copilot"),
    require("plugins.gitsigns"),
    {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
      keys = {
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer Local Keymaps (which-key)",
        },
      },
    },
    {
      'nvimdev/dashboard-nvim',
      event = 'VimEnter',
      config = function()
        require('dashboard').setup {
          theme = 'hyper',
          config = {
            week_header = {
              enable = true,
            },
            shortcut = {
              { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
              {
                icon = ' ',
                icon_hl = '@variable',
                desc = 'Files',
                group = 'Label',
                action = 'Telescope find_files',
                key = 'f',
              },
              {
                desc = ' Apps',
                group = 'DiagnosticHint',
                action = 'Telescope app',
                key = 'a',
              },
              {
                desc = ' dotfiles',
                group = 'Number',
                action = 'Telescope dotfiles',
                key = 'd',
              },
            },
          },
        }
      end,
      dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    },
    { 'mbbill/undotree' },
    { 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    { "nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate" },
    { 'nvim-mini/mini.surround',         version = false },
    {
      "mason-org/mason.nvim",
      opts = {}
    },
    {
      "mason-org/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "lua_ls", "rust_analyzer", "pyright", "html", "cssls", "emmet_ls" },
      },
      dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
      },
    },
    {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = true
      -- use opts = {} for passing setup options
      -- this is equivalent to setup({}) function
    },
    {
      'jinh0/eyeliner.nvim',
      config = function()
        require 'eyeliner'.setup {
          -- show highlights only after keypress
          highlight_on_key = true,

          -- dim all other characters if set to true (recommended!)
          dim = false,

          -- set the maximum number of characters eyeliner.nvim will check from
          -- your current cursor position; this is useful if you are dealing with
          -- large files: see https://github.com/jinh0/eyeliner.nvim/issues/41
          max_length = 9999,

          -- filetypes for which eyeliner should be disabled;
          -- e.g., to disable on help files
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
    }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "catppuccin" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})


require("plugins.treesitter")
require("plugins.telescope")
require("mason-lspconfig").setup()
require('lualine').setup(
  { options = { theme = 'dracula' } }
)
require("bufferline").setup({
  options = {
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
  },
})
