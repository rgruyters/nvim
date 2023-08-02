return {
    settings = {
        json = {
            schemas = vim.list_extend(
                {
                    {
                        description = "pyright config",
                        fileMatch = { "pyrightconfig.json" },
                        name = "pyrightconfig.json",
                        url = "https://raw.githubusercontent.com/microsoft/pyright/main/packages/vscode-pyright/schemas/pyrightconfig.schema.json",
                    },
                },
            ),
        },
    },
}
