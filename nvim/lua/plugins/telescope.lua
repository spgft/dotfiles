return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").setup({
        defaults = {
          layout_config = {
            horizontal = { width = 0.9 },
            vertical = { width = 0.9 },
          },
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
        },
      })
    end,
  },
}
