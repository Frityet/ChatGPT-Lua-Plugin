---@diagnostic disable: lowercase-global
package = "chatgpt-lua-plugin"

version = "dev-1"

source = {
    url = "*** please add URL for source tarball, zip or repository here ***"
}
description = {
    homepage = "*** please enter a project homepage ***",
    license = "GPLv3"
}
dependencies = {
    "lua ~> 5.1",
    "lapis",
    "lua-cjson",
    "lyaml",
    "penlight"
}

build = {
    type = "builtin",
    modules = {
    }
}
