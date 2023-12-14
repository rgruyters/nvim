return {
  -- NOTE: This is where your plugins related to LSP can be installed.
  --       The configuration is done in lua/kickstart/plugins/lsp.lua.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Additional lua configuration, makes nvim stuff amazing!
      { 'folke/neodev.nvim', opts = {} },
    },
    opts = {
      servers = {
        -- NOTE: This is where you add the LSP servers you want to use.
        --       You can find the full list of available servers here:
        --       https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' },
              },
              workspace = {
                library = {
                  [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                  [vim.fn.stdpath('config') .. '/lua'] = true,
                },
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(_, bufnr)
        -- NOTE: Remember that lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself
        -- many times.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local kmap = function(mode, keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
        end

        kmap('n', '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        kmap('n', '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        kmap('n', 'gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        kmap('n', 'gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        kmap('n', 'gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        kmap('n', '<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        kmap('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        kmap('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        kmap('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
        kmap({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        kmap('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        kmap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        kmap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        kmap('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })

        kmap('n', '<space>f', '<cmd>Format<CR>', { buffer = bufnr, desc = '[F]ormat current buffer' })
      end

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      local servers = opts.servers

      -- Load Mason LSP support
      local mason_lspconfig = require('mason-lspconfig')

      local ensure_installed = {} ---@type string[]
      for server, _ in pairs(servers) do
        ensure_installed[#ensure_installed + 1] = server
      end

      mason_lspconfig.setup({
        ensure_installed = ensure_installed,
        automatic_installation = false,
      })

      -- Add any additional override configuration, filetypes, etc.
      mason_lspconfig.setup_handlers({
        function(server_name)
          require('lspconfig')[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = (servers[server_name] or {}).settings,
            filetypes = (servers[server_name] or {}).filetypes,
          })
        end,
      })
    end,
  },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    build = ':MasonUpdate',
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')
      mr:on('package:install:success', function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require('lazy.core.handler.event').trigger({
            event = 'FileType',
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    optional = true,
    event = 'VeryLazy',
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, 1, {
        function()
          local buf_clients = vim.lsp.get_active_clients{ bufnr = 0 }
          if #buf_clients == 0 then
            return 'LS Inactive'
          end

          local buf_ft = vim.bo.filetype
          local buf_client_names = {}

          -- add client
          for _, client in pairs(buf_clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes,buf_ft) ~= -1 then
              table.insert(buf_client_names, client.name)
            end
          end

          -- FIXME: Need to find a way to load this modular, within formatting.lua
          local ok, conform = pcall(require, "conform")
          if ok then
            local formatters = conform.list_formatters(0)
            if not conform.will_fallback_lsp() then
              for _, formatter in ipairs(formatters) do
                table.insert(buf_client_names, formatter.name)
              end
            end
          end

          -- join buffer client names with commas
          local unique_client_names = table.concat(buf_client_names, ", ")
          local language_servers = string.format("[%s]", unique_client_names)

          return language_servers
        end,
        cond = function() return vim.o.columns > 80 end,
        color = { fg = '#616E88' },
      })
    end,
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
