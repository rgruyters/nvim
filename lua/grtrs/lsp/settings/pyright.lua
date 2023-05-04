return {
    settings = {
        pyright = {
            disableLanguageServices = false,
            disableOrganizeImports = false
        },
        python = {
            analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                typeCheckingMode = "basic",
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
                inlayHints = {
                    variableTypes = true,
                    functionReturnTypes = true,
                },
            },
        },
    },
}
