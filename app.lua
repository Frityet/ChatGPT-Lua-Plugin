local lapis = require("lapis")
local json_params = require("lapis.application").json_params
local yaml = require("lyaml")
local stringio = require("pl.stringio")
local app = lapis.Application()

app:get("/.well-known/ai-plugin.json", function(res)
    return {
        json = require("ai-plugin")
    }
end)

app:get("/openapi.yaml", function()
    return yaml.dump { require("openapi") }, {
        layout = false,
        content_type = "text/yaml",
    }
end)


app:get("/logo.png", function()
    return { redirect_to = "https://48pedia.org/images/thumb/8/8e/Lua-logo.svg/1200px-Lua-logo.svg.png?20200118144036" }
end)

app:post("/lua", json_params(function(req)
    local code = req.params.code
    local stdout, stderr = stringio.create(), stringio.create()

    local func, err = load(code, "lua", "t", setmetatable({
        io = setmetatable({ stdout = stdout, stderr = stderr, }, { __index = io, }),
        print = function(...)
            local args = {...}
            for i in ipairs(args) do
                args[i] = tostring(args[i])
            end
            stdout:write(table.concat(args, "\t").."\n")
        end,

        error = function(...)
            local args = {...}
            for i in ipairs(args) do
                args[i] = tostring(args[i])
            end
            stderr:write(table.concat(args, "\t").."\n")
        end,
    }, { __index = _G }))
    if not func then return { json = { error = err } } end

    local ok, err, res = pcall(func)
    if not ok then
        return {
            json = {
                error = tostring(err),
                stdout = stdout:value(),
                stderr = stderr:value(),
            }
        }
    end

    return {
        json = {
            return_value = tostring(err),
            stdout = stdout:value(),
            stderr = stderr:value(),
        }
    }
end))

return app
