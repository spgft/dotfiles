return {
  {
    "vague2k/vague.nvim",
    config = function()
      require("vague").setup({
        -- your vague.nvim options, optional
        -- transparent = true, -- vague.nvim supports this option!
        style = {
          boolean = "none",
          number = "none",
          float = "none",
          error = "none",
          comments = "none",
          conditionals = "none",
          functions = "none",
          headings = "bold",
          operators = "none",
          strings = "none",
          variables = "none",
          keywords = "none",
          keyword_return = "none",
          keywords_loop = "none",
          keywords_label = "none",
          keywords_exception = "none",
          builtin_constants = "none",
          builtin_functions = "none",
          builtin_types = "none",
          builtin_variables = "none",
        },
        colors = {
          -- customize colors here if you want
        },
      })

      -- Apply the theme
      vim.cmd("colorscheme vague")

      -- Make background transparent:
      vim.cmd([[
        hi Normal guibg=NONE ctermbg=NONE
        hi NormalFloat guibg=NONE ctermbg=NONE
        hi SignColumn guibg=NONE ctermbg=NONE
        hi VertSplit guibg=NONE ctermbg=NONE
        hi StatusLine guibg=NONE ctermbg=NONE
        hi LineNr guibg=NONE ctermbg=NONE
      ]])
    end,
  },
}

