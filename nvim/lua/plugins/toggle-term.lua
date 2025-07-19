return{
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      direction = "float",
      float_opts = {
        border = "curved",
      },
      start_in_insert = true,
      close_on_exit = false,
    })

    function _G.run_code()
      local filename = vim.fn.expand("%:t")
      local without_ext = vim.fn.expand("%:r")
      local ext = vim.fn.expand("%:e")

      local cmd = ""
      if ext == "c" then
        cmd = string.format("gcc %s -o %s && ./%s", filename, without_ext, without_ext)
      elseif ext == "cpp" or ext == "cc" then
        cmd = string.format("g++ %s -o %s && ./%s", filename, without_ext, without_ext)
      elseif ext == "py" then
        cmd = string.format("python3 %s", filename)
      else
        print("Unsupported file type: " .. ext)
        return
      end

      require("toggleterm.terminal").Terminal:new({
        cmd = cmd,
        direction = "float",
        close_on_exit = false,
      }):toggle()
    end

    vim.api.nvim_set_keymap("n", "<F8>", "<cmd>lua run_code()<CR>", { noremap = true, silent = true })
  end,
}

