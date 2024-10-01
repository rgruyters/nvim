return {
  'ThePrimeagen/git-worktree.nvim',
  dependencies = { 'telescope.nvim' },
  event = 'VimEnter',
  opts = {},
  keys = {
    { '<leader>gw', "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", { silent = true, desc = 'Show Git worktrees' } },
    { '<leader>gW', "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", { silent = true, desc = 'Create Git worktree' } },
  },
  config = function(_, opts)
    require('git-worktree').setup(opts)
    require('telescope').load_extension('git_worktree')
  end,
}
