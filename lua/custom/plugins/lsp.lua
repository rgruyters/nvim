return {
  {
    'nvim-lualine/lualine.nvim',
    optional = true,
    event = 'VeryLazy',
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, 1, {
        function()
          local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })

          local buf_ft = vim.bo.filetype
          local buf_client_names = {}

          -- add client
          for _, client in pairs(buf_clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              table.insert(buf_client_names, client.name)
            end
          end

          -- FIXME: Need to find a way to load this modular, within formatting.lua
          local conform_ok, conform = pcall(require, 'conform')
          if conform_ok then
            local formatters = conform.list_formatters_for_buffer(0)
            if not conform.will_fallback_lsp() then
              table.insert(buf_client_names, table.concat(formatters, ', '))
            end
          end

          -- FIXME: Need to find a way to load this modular, within linting.lua
          local lint_ok, nl = pcall(require, 'lint')
          if lint_ok then
            local linters = nl.linters_by_ft[vim.bo.filetype]
            if linters ~= nil then
              for linter in pairs(linters) do
                table.insert(buf_client_names, linters[linter])
              end
            end
          end

          if #buf_clients == 0 and #buf_client_names == 1 then
            return 'LS Inactive'
          end

          -- join buffer client names with commas
          local unique_client_names = table.concat(buf_client_names, ', ')
          local language_servers = string.format('[%s]', unique_client_names)

          return language_servers
        end,
        cond = function()
          return vim.o.columns > 80
        end,
        color = { fg = '#616E88' },
      })
    end,
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
