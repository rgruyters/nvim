-- Use relative numbers
vim.o.relativenumber = true

-- highlight the current line
vim.o.cursorline = true

-- we don't need to see things like -- INSERT -- anymore
vim.o.showmode = false

-- force all horizontal splits to go below current window
vim.o.splitbelow = true

-- force all vertical splits to go to the right of current window
vim.o.splitright = true

-- convert tabs to spaces
vim.o.expandtab = true

-- honour indenting
vim.o.shiftround = true

-- the number of spaces inserted for each indentation
vim.o.shiftwidth = 4

-- insert spaces for a tab
vim.o.tabstop = 4

-- Number of spaces that a tab counts for while performing editing operations
vim.o.softtabstop = 4

vim.o.smartindent = true

-- do not create swap- or backup files
vim.o.swapfile = false
vim.o.backup = false

-- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.o.writebackup = false

-- enable persistent undo
vim.o.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.o.undofile = true

-- only the last window will always have a status line
vim.o.laststatus = 3

-- more space in the neovim command line for displaying messages
vim.o.cmdheight = 1

-- hide (partial) command in the last line of the screen (for performance)
vim.o.showcmd = false

-- minimal number of screen lines to keep above and below the cursor
vim.o.scrolloff = 8

-- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`
vim.o.sidescrolloff = 8

vim.o.title = true

-- time to wait for a mapped sequence to complete (in milliseconds)
vim.o.timeoutlen = 300

-- faster completion (4000ms default)
vim.o.updatetime = 250

-- Netrw settings
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- always write files as utf-8
vim.g.fileencoding = 'utf-8'

-- show empty lines at the end of a buffer as ` ` {default `~`}
vim.opt.fillchars.eob = ' '

-- hide all the completion messages, e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"
vim.opt.shortmess:append('c')

-- keys allowed to move to the previous/next line when the beginning/end of line is reached
vim.opt.whichwrap:append('<,>,[,],h,l')

-- treats words with `-` as single words
vim.opt.iskeyword:append('-')

-- when enabled show specific characters when list is enabled
vim.opt.listchars:append('eol:↴')

vim.opt.formatoptions = 'jcroqlnt'
vim.opt.grepformat = '%f:%l:%c:%m'
vim.opt.grepprg = 'rg --vimgrep'
