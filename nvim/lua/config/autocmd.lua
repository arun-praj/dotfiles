vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Trigger LSP formatting on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})


vim.diagnostic.config({
  virtual_text = {
    prefix = "●", -- symbol before the message
    spacing = 2,
    source = "if_many", -- show the LSP server name only if multiple
  },
  signs = false, -- disable W/E/H in gutter
  underline = true, -- underline the problem
  update_in_insert = false,
})

-- Function to open external terminal in current working directory
function OpenTerminal()
  local cwd = vim.fn.getcwd()

  if vim.fn.has("macunix") == 1 then
    -- macOS: open Kitty in current working dir
    vim.fn.jobstart({ "kitty" }, { cwd = cwd, detach = true })
  elseif vim.fn.has("win32") == 1 then
    -- Windows: open PowerShell in current working dir
    vim.fn.jobstart({ "powershell.exe" }, { cwd = cwd, detach = true })
  else
    -- Linux fallback: also try Kitty
    vim.fn.jobstart({ "kitty" }, { cwd = cwd, detach = true })
  end
end

-- Command
vim.api.nvim_create_user_command("OpenTerminal", OpenTerminal, {})

-- Keymap
vim.keymap.set("n", "<leader>t", ":OpenTerminal<CR>", { noremap = true, silent = true, desc = "Open external terminal" })
