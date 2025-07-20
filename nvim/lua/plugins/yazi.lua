return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>e",
      "<cmd>Yazi cwd<cr>",
      desc = "Open Yazi file manager in current directory",
    },
  },
  opts = {
    open_for_directories = false,
    keymaps = {
      show_help = "<f1>",
      quit = "q", -- map `q` to quit the floating window
    },
    yazi_floating_window_border = "none",
  },
}

