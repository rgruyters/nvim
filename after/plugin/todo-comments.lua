local nmap = require("grtrs.functions").nmap

local todo_comments_loaded, todo_comments = pcall(require, "todo-comments")
if not todo_comments_loaded then
    return
end

-- Better overview of all possible settings
-- https://github.com/folke/todo-comments.nvim#%EF%B8%8F-configuration
todo_comments.setup {
    highlight = {
        before = "", -- "fg" or "bg" or empty
        keyword = "wide_fg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty
        after = "fg", -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
        comments_only = true, -- uses treesitter to match keywords in comments only
        max_line_len = 400, -- ignore lines longer than this
        exclude = {}, -- list of file types to exclude highlighting
    },
}

nmap("<leader>ft", "<cmd>TodoTelescope keywords=TODO,FIX,HACK<CR>", "Telescope: [F]ind [T]odo")
