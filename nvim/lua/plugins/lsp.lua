return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "windwp/nvim-ts-autotag",        -- <-- For auto-closing HTML tags
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      mason.setup()
      mason_lspconfig.setup({
        ensure_installed = {
          "clangd",
          "pyright",
          "html",
          "cssls",
          "ts_ls",
          "lua_ls",
          "emmet_ls", -- <-- install Emmet
        },
      })

      require("nvim-ts-autotag").setup() -- enable tag auto-closing

      local on_attach = function(client, bufnr)
        local buf_map = function(mode, lhs, rhs, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        buf_map("n", "gd", vim.lsp.buf.definition)
        buf_map("n", "K", vim.lsp.buf.hover)
        buf_map("n", "gi", vim.lsp.buf.implementation)
        buf_map("n", "<leader>rn", vim.lsp.buf.rename)
        buf_map("n", "<leader>ca", vim.lsp.buf.code_action)
        buf_map("n", "gr", vim.lsp.buf.references)
        buf_map("n", "[d", vim.diagnostic.goto_prev)
        buf_map("n", "]d", vim.diagnostic.goto_next)
        buf_map("n", "<leader>q", vim.diagnostic.setloclist)
        buf_map("n", "<leader>f", function() vim.lsp.buf.format { async = true } end)
      end

      local capabilities = cmp_nvim_lsp.default_capabilities()

      local servers = {
        clangd = {
          cmd = { "/usr/bin/clangd" },
        },
        pyright = {},
        html = {},
        cssls = {},
        ts_ls = {},
        emmet_ls = {
          filetypes = { "html", "css", "typescriptreact", "javascriptreact" },
        },
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          },
        },
      }

      for server, config in pairs(servers) do
        config.on_attach = on_attach
        config.capabilities = capabilities
        lspconfig[server].setup(config)
      end
    end,
  },
}

