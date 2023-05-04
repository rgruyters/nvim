local schemastore_loaded, schemastore = pcall(require, "schemastore")
if not schemastore_loaded then
    return
end

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
                schemastore.json.schemas {
                }
            ),
        },
    },
}
