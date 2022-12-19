-- Setup nvim-cmp.
local npairs_loaded, npairs = pcall(require, "nvim-autopairs")
if not npairs_loaded then
    return
end

npairs.setup {
    check_ts = true, -- treesitter integration
    disable_filetype = { "TelescopePrompt" },
}

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_loaded, cmp = pcall(require, "cmp")
if not cmp_loaded then
    return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done {})
