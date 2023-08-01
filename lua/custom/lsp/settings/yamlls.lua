local schemastore_loaded, schemastore = pcall(require, "schemastore")
if not schemastore_loaded then
    return
end

return {
    settings = {
        yaml = {
            schemas = schemastore.yaml.schemas(),
        },
    },
}
