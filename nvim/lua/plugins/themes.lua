
return {
  {
    "vague2k/vague.nvim",
    name = "vague",
    priority = 1000,
    config = function()
      require("vague").setup({
        transparent = true,  -- enable transparent background if you want
        style = {
          boolean = "none",
          number = "none",
          float = "none",
          error = "none",
          comments = "none",
          conditionals = "none",
          functions = "none",
          headings = "none",
          keywords = "none",
          loops = "none",
          numbers = "none",
          operators = "none",
          punctuation = "none",
          strings = "none",
          types = "none",
          variables = "none",
        },
      })
      vim.cmd("colorscheme vague")
    end,
  }
}

