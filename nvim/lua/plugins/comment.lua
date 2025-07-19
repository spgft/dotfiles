return {
  "numToStr/Comment.nvim",
  config = function()
    require('Comment').setup({
      toggler = {
        line = "gc",   -- normal mode: gc toggles line comment on current line
        block = "gb",  -- normal mode: gb toggles block comment on current line (rarely used)
      },
      opleader = {
        line = "gc",   -- operator-pending: gc + motion toggles line comment on range
        block = "gb",  -- operator-pending: gb + motion toggles block comment on range
      },
      -- disable extra keymaps to keep it clean
      extra = {
        above = nil,
        below = nil,
        eol = nil,
      },
    })
  end,
}

