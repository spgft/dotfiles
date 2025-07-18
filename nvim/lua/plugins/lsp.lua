return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    mason.setup()

    vim.diagnostic.config({
      virtual_text = {
        prefix = "●",
        spacing = 2,
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      vim.fn.sign_define("DiagnostiSign" .. type, { text = icon, texthl = "", numhl = "" })
    end

    local capabilities = cmp_nvim_lsp.default_capabilities()

    local on_attach = function(client, bufnr)
      local keymap = vim.keymap
      local opts = { buffer = bufnr, silent = true }

      keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      keymap.set("n", "gr", vim.lsp.buf.references, opts)
      keymap.set("n", "K", vim.lsp.buf.hover, opts)
      keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
    end

    -- 🧹 Filter out unwanted diagnostic messages globally
    local orig_handler = vim.diagnostic.handlers.virtual_text
    vim.diagnostic.handlers.virtual_text = {
      show = function(ns, bufnr, diagnostics, opts)
        local filtered = {}
        for _, diagnostic in ipairs(diagnostics) do
          if not diagnostic.message:match("header is unused")
            and not diagnostic.message:match("is declared but never used")
            and not diagnostic.message:match("included but not used") then
            table.insert(filtered, diagnostic)
          end
        end
        orig_handler.show(ns, bufnr, filtered, opts)
      end,
      hide = function(ns, bufnr)
        orig_handler.hide(ns, bufnr)
      end,
    }

    local orig_float = vim.diagnostic.open_float
    vim.diagnostic.open_float = function(bufnr, opts)
      opts = opts or {}
      opts.severity = {
        min = vim.diagnostic.severity.HINT,
        max = vim.diagnostic.severity.ERROR,
      }
      opts.scope = "line"
      opts.filter = function(diagnostic)
        return not diagnostic.message:match("header is unused")
          and not diagnostic.message:match("is declared but never used")
          and not diagnostic.message:match("included but not used")
      end
      return orig_float(bufnr, opts)
    end

    -- Setup servers
    lspconfig["html"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["cssls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["ts_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["pyright"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      before_init = function(params)
        local function get_python_path()
          local cwd = vim.fn.getcwd()

          local venv = os.getenv("VIRTUAL_ENV")
          if venv and vim.fn.executable(venv .. "/bin/python") == 1 then
            return venv .. "/bin/python"
          end

          local venv_names = { ".venv", "venv", "env", ".env" }
          for _, name in ipairs(venv_names) do
            local path = cwd .. "/" .. name .. "/bin/python"
            if vim.fn.filereadable(path) == 1 then
              return path
            end
          end

          local pyenv_root = os.getenv("PYENV_ROOT") or os.getenv("HOME") .. "/.pyenv"
          local handle = io.popen("pyenv version-name")
          local version = handle and handle:read("*l")
          if handle then handle:close() end
          if version and version ~= "" then
            local pyenv_python = pyenv_root .. "/versions/" .. version .. "/bin/python"
            if vim.fn.executable(pyenv_python) == 1 then
              return pyenv_python
            end
          end

          return vim.fn.exepath("python3") or "python3"
        end

        local python_path = get_python_path()
        params.settings = params.settings or {}
        params.settings.python = params.settings.python or {}
        params.settings.python.pythonPath = python_path
      end,
    })

    lspconfig["clangd"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["emmet_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = {
        "html",
        "css",
        "scss",
        "sass",
        "less",
        "typescriptreact",
        "javascriptreact",
      },
    })
  end,
}

