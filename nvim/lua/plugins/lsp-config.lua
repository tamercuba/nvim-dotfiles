local ensure_installed = { 'lua_ls', 'rust_analyzer', 'ruff', "pylsp", "pyright", "gopls" }

local function get_python_executable()
  local venv_path = os.getenv('VIRTUAL_ENV')
  if venv_path then
    return venv_path .. '/bin/python'
  else
    return 'python' -- Default to system python if VIRTUAL_ENV is not set
  end
end

local function setup_keymaps(_, bufnr)
  local opts = { buffer = bufnr, remap = false }
  local map = vim.keymap.set

  map("n", "gd", vim.lsp.buf.definition, opts)
  map("n", "K", vim.lsp.buf.hover, opts)
  map("n", "<leader>vw", vim.lsp.buf.workspace_symbol,
    { desc = 'Search symbol in [W]orkspace', buffer = bufnr, remap = false })
  map("n", "<leader>vd", vim.diagnostic.open_float, { desc = "[V]iew [D]iagnostics", buffer = bufnr, remap = false })
  map("n", "[d", vim.diagnostic.goto_next, opts)
  map("n", "]d", vim.diagnostic.goto_prev, opts)
  map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  map("n", "gr", vim.lsp.buf.references, opts)
  map("n", "<leader>vr", vim.lsp.buf.rename, { desc = '[R]ename', buffer = bufnr, remap = false })
  map("n", "<leader>vh", vim.lsp.buf.signature_help, { desc = 'Signature [H]elp', buffer = bufnr, remap = false })
end

local function get_capabilities()
  require('cmp_nvim_lsp').default_capabilities()
end

return {
  {
    "williamboman/mason.nvim",
    config = function()
      require('mason').setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
      })
    end
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    config = function()
      local lsp = require('lsp-zero')
      lsp.preset('recommended')
      lsp.ensure_installed = ensure_installed

      lsp.set_preferences({
        suggest_lsp_servers = false,
        sign_icons = {
          error = 'E',
          warn = 'W',
          hint = 'H',
          info = 'I'
        }
      })

      lsp.on_attach(setup_keymaps)

      lsp.setup()
      vim.diagnostic.config({
        virtual_text = true
      })
    end
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require('lsp-zero').extend_lspconfig()
      local lsp = require('lspconfig')

      local function setup_lsp(server, config, on_attach)
        config = config or {}
        on_attach = on_attach or setup_keymaps

        config.capabilities = get_capabilities()
        config.on_attach = on_attach
        lsp[server].setup(config)
      end

      setup_lsp('lua_ls')
      local rust_on_attach = function(_, bufnr)
        setup_keymaps(_, bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end
      setup_lsp('rust_analyzer', {
        settings = {
          ['rust_analyzer'] = {
            imports = { granularity = { group = 'module' }, prefix = 'self' },
            cargo = { buildScripts = { enable = true } },
            procMacro = { enable = true }
          }
        },
      }, rust_on_attach)
      setup_lsp('ruff', {
        before_init = function(params)
          params.processId = vim.NIL
          params.rootPath = vim.fn.getcwd()
          params.rootUri = vim.uri_from_fname(vim.fn.getcwd())
          params.initializationOptions = { pythonPath = get_python_executable() }
        end,
        settings = {
          ruff = {
            pythonPath = get_python_executable(),
          },
        },
      })
      setup_lsp('pyright', {
        before_init = function(params)
          params.processIs = vim.NIL
          params.rootPath = vim.fn.getcwd()
          params.rootUri = vim.uri_from_fname(vim.fn.getcwd())
          params.initializationOptions = { pythonPath = get_python_executable() }
        end,
        settings = {
          python = {
            pythonPath = get_python_executable(),
            typeCheckingMode = 'off',
            analyzeUnannotatedFunctions = false,
            reportReturnType = false,
            diagnosticMode = 'openFilesOnly',
            useLibraryCodeForTypes = true

          },
        }
      })
      setup_lsp('gopls', {
        {
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          }
        }
      })
      setup_lsp('clojure_lsp')
      setup_lsp('pylsp', {
        settings = {
          pylsp = {
            plugins = {
              pylsp_mypy = {
                enabled = true,
                overrides = { "--python-executable", get_python_executable(), true, "--disallow-untyped-calls" },
                report_progress = true,
                live_mode = true,
                strict = true,

              }
            }
          },
        }
      })
    end
  },
  { 'hrsh7th/cmp-nvim-lsp' },
  {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        sources = { { name = 'nvim_lsp' }, { name = 'buffer' } },
        mapping = {
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<c-Space>'] = cmp.mapping.complete(),
          ['<c-e>'] = cmp.mapping.abort(),
          ['<Up>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
          ['<Down>'] = cmp.mapping.select_next_item({ behavior = 'select' }),
          ['<c-k>'] = cmp.mapping(function()
            if cmp.visible() then cmp.select_prev_item({ behavior = 'insert' }) else cmp.complete() end
          end),
          ['<c-j>'] = cmp.mapping(function()
            if cmp.visible() then cmp.select_next_item({ behavior = 'insert' }) else cmp.complete() end
          end),
        },
        snippet = {
          expand = function(args) require('luasnip').lsp_expand(args.body) end,
          completion = {
            autocomplete = { require('cmp.types').cmp.TriggerEvent.TextChanged }
          }
        }
      })
    end
  },
  { 'L3MON4D3/LuaSnip' },
}
