return {
  {
    'nvim-lualine/lualine.nvim',
    optional = true,
    event = 'VeryLazy',
    opts = function(_, opts)
      local started = false
      local function status()
        if not package.loaded['cmp'] then
          return
        end
        for _, s in ipairs(require('cmp').core.sources) do
          if s.name == 'codeium' then
            if s.source:is_available() then
              started = true
            else
              return started and 'error' or nil
            end
            if s.status == s.SourceStatus.FETCHING then
              return 'pending'
            end
            return 'ok'
          end
        end
      end

      table.insert(opts.sections.lualine_x, 2, {
        function()
          return require('custom.icons').kind.Codeium
        end,
        cond = function()
          return status() ~= nil
        end,
        separator = '',
      })
    end
  },
  -- Plugin: GitHub Copilot completion integration
  {
    'nvim-cmp',
    event = { 'InsertEnter' },
    dependencies = {
      'Exafunction/codeium.nvim',
      cmd = 'Codeium',
      build = ':Codeium Auth',
      opts = {},
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, 1, { name = 'codeium', group_index = 1 })
      opts.sorting = opts.sorting or require('cmp.config.default')().sorting
      table.insert(opts.sorting.comparators, 1, require('copilot_cmp.comparators').prioritize)
    end,
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
