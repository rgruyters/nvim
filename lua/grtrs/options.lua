vim.opt.completeopt = { "menu", "menuone", "noselect" } -- Set completeopt to have a better completion experience
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file

vim.opt.hlsearch = false                        -- highlight all matches on previous search pattern
vim.opt.incsearch = true                        -- show match when searching
vim.opt.ignorecase = true                       -- ignore case in search patterns

vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim
vim.opt.pumheight = 10                          -- pop up menu height

vim.opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 0                         -- always show tabs

vim.opt.smartcase = true                        -- smart case
vim.opt.smartindent = true                      -- make indenting smarter again

vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window

vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)

vim.opt.timeoutlen = 300                        -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.updatetime = 250                        -- faster completion (4000ms default)

vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.backup = false                          -- creates a backup file
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true                         -- enable persistent undo

vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.shiftwidth = 4                          -- the number of spaces inserted for each indentation
vim.opt.shiftround = true                       -- honour indenting
vim.opt.tabstop = 4                             -- insert spaces for a tab
vim.opt.softtabstop = 4                         -- Number of spaces that a tab counts for while performing editing operations

vim.opt.cursorline = true                       -- highlight the current line
vim.opt.number = true                           -- set numbered lines
vim.opt.relativenumber = true                   -- Use relative numbers
vim.opt.ruler = false                           -- hide the line and column number of the cursor position
vim.opt.numberwidth = 4                         -- set number column width to 2 {default 4}

vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false                            -- display lines as one long line

vim.opt.laststatus = 3                          -- only the last window will always have a status line
vim.opt.cmdheight = 1                           -- more space in the neovim command line for displaying messages
vim.opt.showcmd = false                         -- hide (partial) command in the last line of the screen (for performance)
vim.opt.scrolloff = 8                           -- minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8                       -- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`

vim.opt.title = true

vim.opt.fillchars.eob=" "                       -- show empty lines at the end of a buffer as ` ` {default `~`}
vim.opt.shortmess:append "c"                    -- hide all the completion messages, e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"
vim.opt.whichwrap:append("<,>,[,],h,l")         -- keys allowed to move to the previous/next line when the beginning/end of line is reached
vim.opt.iskeyword:append("-")                   -- treats words with `-` as single words
vim.opt.listchars:append("eol:↴")                -- when enabled show specific characters when list is enabled
vim.opt.list = false                            -- do not show tabs, trailing spaces and returns

-- Custom settings for Explore
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
