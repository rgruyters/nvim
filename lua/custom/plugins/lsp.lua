return {
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
          local conform_ok, conform = pcall(require, 'conform')
          if conform_ok then
            local formatters = conform.list_formatters(0)
            if not conform.will_fallback_lsp() then
              for _, formatter in ipairs(formatters) do
                table.insert(buf_client_names, formatter.name)
              end
            end
          end

          -- FIXME: Need to find a way to load this modular, within linting.lua
          local lint_ok, nl = pcall(require, 'lint')
          if lint_ok then
            local linters = nl.get_running()
            for _, linter in ipairs(linters) do
              table.insert(buf_client_names, linter)
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