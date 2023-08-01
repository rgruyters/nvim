-- Plugin: Surround selections
return {
	"kylechui/nvim-surround",
	event = { "BufReadPost", "BufNewFile" },
	version = "*",       -- Use for stability; omit to use `main` branch for the latest features
	config = true,
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
