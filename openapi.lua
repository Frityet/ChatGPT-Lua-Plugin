local shared = require("shared")

return {
    openapi = "3.0.1",
    info = {
        title = "Lua plugin",
        description = "A plugin that allows the user to execute Lua code.",
        version = "v1"
    },
    servers = {
        { url = "http://localhost:"..shared.port }
    },
    paths = {
        ["/lua"] = {
            post = {
                operationId = "execute",
                summary = "Execute Lua code",
                requestBody = {
                    required = true,
                    content = {
                        ["application/json"] = {
                            schema = {
                                type = "object",
                                properties = {
                                    code = {
                                        type = "string",
                                        description = "The Lua code to execute."
                                    }
                                }
                            }
                        }
                    }
                },
                responses = {
                    ["200"] = {
                        description = "OK",
                        content = {
                            ["application/json"] = {
                                schema = {
                                    ["$ref"] = "#/components/schemas/executeResponse"
                                }
                            }
                        }
                    }
                }
            }
        },
    },
    components = {
        schemas = {
            executeResponse = {
                type = "object",
                properties = {
                    return_value = {
                        type = "string",
                        description = "The return value of the lua code."
                    },
                    error = {
                        type = "string",
                        description = "The error message if the code failed to execute."
                    },
                    stdout = {
                        type = "string",
                        description = "The output of the code."
                    },
                    stderr = {
                        type = "string",
                        description = "The error output of the code."
                    }
                }
            }
        }
    }
}
