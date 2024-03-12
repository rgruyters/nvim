return {
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    build = ':MasonUpdate',
    opts = {
      ensure_installed = {},
    },
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')

      -- check if packages need to be installed
      mr.refresh(function()
        for _, pkg_name in ipairs(opts.ensure_installed) do
          local pkg = mr.get_package(pkg_name)
          if not pkg:is_installed() then
            vim.notify(string.format('Installing %s', pkg_name), vim.log.levels.INFO, { title = 'mason' })
            pkg:install()
          end
        end
      end)
    end,
  },
}
