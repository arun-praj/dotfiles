return {
  -- Official GitHub Copilot plugin
  {
    "github/copilot.vim",
    config = function()
      -- Disable default Tab mapping (avoid conflicts with nvim-cmp / Smart Tab)
      vim.g.copilot_no_tab_map = true

      -- Keymaps for Copilot
      local opts = { silent = true, expr = true }

      -- Accept suggestion
      vim.api.nvim_set_keymap("i", "<C-Enter>", 'copilot#Accept("<CR>")', opts)

      -- Trigger suggestion manually
      vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Suggest()', opts)

      -- Cycle through suggestions
      vim.api.nvim_set_keymap("i", "<C-K>", 'copilot#Next()', opts)
      vim.api.nvim_set_keymap("i", "<C-H>", 'copilot#Previous()', opts)
    end
  },

  -- Optional: integrate Copilot into nvim-cmp popup menu
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "github/copilot.vim", "hrsh7th/nvim-cmp" },
    config = function()
      require("copilot_cmp").setup({
        method = "getCompletionsCycling", -- recommended
        formatters = {
          insert_text = require("copilot_cmp.format").remove_existing,
        },
      })
    end
  }
}
