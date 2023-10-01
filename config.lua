local config = require("lapis.config")

local shared = require("shared")

config("development", {
  server = "nginx",
  code_cache = "off",
  num_workers = "1",
  port = tostring(shared.port)
})
