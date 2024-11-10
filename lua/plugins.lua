return {

    -- MASON (LSP for Vim)
    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end
    },
    { -- LOAD MASON
      'williamboman/mason-lspconfig.nvim',
      config = function()
        require("mason-lspconfig").setup({
          -- LSP LANGUAGES (MORE IN https://github.com/williamboman/mason-lspconfig.nvim)
          ensure_installed = { 
            "lua_ls", 
            "rust_analyzer", 
            "clangd", 
            "java_language_server", 
            "eslint", 
            "ast_grep", 
            "tailwindcss",
            "hls",
            "bashls",
          },
        })
      end
    },
    {
      "neovim/nvim-lspconfig",
      config = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities()


        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup({
          capabilities = capabilities
        })
        lspconfig.rust_analyzer.setup({
          capabilities = capabilities})
        lspconfig.clangd.setup({
          capabilities = capabilities})
        lspconfig.java_language_server.setup({
          capabilities = capabilities})
        lspconfig.eslint.setup({
          capabilities = capabilities})
        lspconfig.ast_grep.setup({
          capabilities = capabilities})
        lspconfig.tailwindcss.setup({
          capabilities = capabilities})
        lspconfig.hls.setup({
          capabilities = capabilities})
        lspconfig.bashls.setup({
          capabilities = capabilities})
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
        vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
      end
    },




    -- CATPPUCCIN
    {
      "catppuccin/nvim", 
      name = "catppuccin", 
      priority = 1000 
    },



-- TELESCOPE (SPACE + F + G)
    {
      'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
      'nvim-telescope/telescope-ui-select.nvim',
      config = function()
        require("telescope").setup({
          extensions = {
            ["ui-select"] = {
              require("telescope.themes").get_dropdown {
              }
            }
          }
        })
        require("telescope").load_extension("ui-select")
      end
    },




    -- TREE SITTER (SPACE + N)
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", 
        "MunifTanjim/nui.nvim",
      },
    },



    --NONE-LS
    {
      "nvimtools/none-ls.nvim",
      config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort, 
        },
      })
      end
    },



  --DASHBOARD
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        shortcut = {
          { desc = string, group = 'highlight group', key = 'shortcut key', action = 'action when you press key' },
        },
        packages = { enable = true }, -- show how many plugins neovim loaded
        project = { enable = true, limit = 8, icon = 'your icon', label = '', action = 'Telescope find_files cwd=' },
        mru = { enable = true, limit = 10, icon = 'your icon', label = '', cwd_only = false },
        footer = {},
      }
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
  },




  --COMPLETIONS
  {
    "hrsh7th/cmp-nvim-lsp"
  },

  { "hrsh7th/vim-vsnip" },

  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
      "rafamadriz/friendly-snippets",
    }
  },
  
  {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
          -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
          vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), 
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
      }, {
        { name = 'buffer' },
        { name = 'path' },
      })
    })
    end,
  },






  --DEBUGGING
  { "nvim-neotest/nvim-nio" },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'leoluz/nvim-dap-go' -- Debug UI pra GOLANG
    },
    config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    
    require('dapui').setup()
    require('dap-go').setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.keymap.set('n', '<Leader>dt', dap.toggle_breakpoint, {})
    vim.keymap.set('n', "<Leader>dc", dap.continue, {})
    end,
  },
}
