vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- In Visual Mode , if you press J,K it will move the highlighted block up and down resp
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- J will merge the next line to current lint, this will place the cursor at the center on J
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


-- Preserves the yanked value even after replace
vim.keymap.set("x", "<leader>p", [["_dP]])


-- Find and replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
