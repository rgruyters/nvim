return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>fp", "<cmd>Telescope projects<CR>", desc = "[F]ind [P]rojects" },
  },
  opts = {
    active = true,
    on_config_done = nil,
    manual_mode = false,
    -- detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
    detection_methods = { "pattern" },
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
    show_hidden = true,
    silent_chdir = true,
    ignore_lsp = {},
    datapath = vim.fn.stdpath("data"),
  },
  config = function(_, opts)
    require("project_nvim").setup(opts)
    require("telescope").load_extension('projects')
  end,
}
