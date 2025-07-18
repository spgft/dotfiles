require("initials")
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nm.vim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
--load the plugins
require("lazy").setup("plugins")
-- Load your keymaps
require("keymaps")
vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#ffffff", bg = "#ff007c", bold = true })

