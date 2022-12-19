local surround_loaded, surround = pcall(require, "nvim-surround")
if not surround_loaded then
    return
end

surround.setup {}
