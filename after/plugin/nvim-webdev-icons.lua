local nvim_web_devicons_loaded, nvim_web_devicons = pcall(require, "nvim-web-devicons")
if not nvim_web_devicons_loaded then
    return
end

nvim_web_devicons.set_icon {
    sh = {
        icon = "",
        color = "#1DC123",
        cterm_color = "59",
        name = "Sh",
    },
    [".gitattributes"] = {
        icon = "",
        color = "#e24329",
        cterm_color = "59",
        name = "GitAttributes",
    },
    [".gitconfig"] = {
        icon = "",
        color = "#e24329",
        cterm_color = "59",
        name = "GitConfig",
    },
    [".gitignore"] = {
        icon = "",
        color = "#e24329",
        cterm_color = "59",
        name = "GitIgnore",
    },
    [".gitlab-ci.yml"] = {
        icon = "",
        color = "#e24329",
        cterm_color = "166",
        name = "GitlabCI",
    },
    [".gitmodules"] = {
        icon = "",
        color = "#e24329",
        cterm_color = "59",
        name = "GitModules",
    },
    ["diff"] = {
        icon = "",
        color = "#e24329",
        cterm_color = "59",
        name = "Diff",
    },
    ["pp"] = {
        icon = "",
        color = "#FFA61A",
        name = "Pp",
    },
    ["epp"] = {
        icon = "",
        color = "#FFA61A",
        name = "Epp",
    },
}
