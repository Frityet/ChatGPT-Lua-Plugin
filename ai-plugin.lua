local shared = require("shared")

return {
    schema_version = "v1",
    name_for_human = "Lua executor",
    name_for_model = "lua",
    description_for_human = "Execute Lua code",
    description_for_model = "Execute Lua code, the interpreter is ".._VERSION,
    auth = {
        type = "none"
    },
    api = {
        type = "openapi",
        url = "http://localhost:"..shared.port.."/openapi.yaml"
    },
    logo_url = "http://localhost:"..shared.port.."/logo.png",
    contact_email = "ambhogal01@gmail.com",
    legal_info_url = "https://www.gnu.org/licenses/gpl-3.0.html"
}

