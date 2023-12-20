return {
  -- NOTE: for now load *all* languages.
  -- maybe in future make this optional depending on work environment
  { import = 'custom.extras.lang' },
  { import = 'custom.extras.formatters' },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
