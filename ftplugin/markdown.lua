vim.cmd("set tw=80 wrap linebreak")

vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<CR>", { silent = true, desc = "[M]arkdown [P]review" })
