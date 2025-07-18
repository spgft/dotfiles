return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional but recommended
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
          globalstatus = true,
        },
      })
    end,
  },
}
