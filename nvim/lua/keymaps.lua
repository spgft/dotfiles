local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
vim.keymap.set("i", "<C-BS>", "<C-w>", { noremap = true })
-- Telescope keymaps
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<C-a>", "ggVG", opts)
keymap("v", "<C-c>", '"+y', opts)
vim.keymap.set("n", "<leader>df", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
local harpoon = require("harpoon")
-- Add file to Harpoon list
vim.keymap.set("n", "<leader>a", function()
  harpoon:list():append()
end, { desc = "Harpoon Add File", silent = true })

-- Toggle quick menu
vim.keymap.set("n", "<leader>m", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon Menu", silent = true })

-- Vim-like Ctrl key mappings to navigate files
vim.keymap.set("n", "<C-h>", function()
  harpoon:list():select(1)
end, { desc = "Harpoon to file 1", silent = true })

vim.keymap.set("n", "<C-y>", function()
  harpoon:list():select(2)
end, { desc = "Harpoon to file 2", silent = true })

vim.keymap.set("n", "<C-j>", function()
  harpoon:list():select(3)
end, { desc = "Harpoon to file 3", silent = true })

vim.keymap.set("n", "<C-u>", function()
  harpoon:list():select(4)
end, { desc = "Harpoon to file 4", silent = true })
