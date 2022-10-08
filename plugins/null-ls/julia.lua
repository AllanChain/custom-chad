local h = require("null-ls.helpers")
local methods = require("null-ls.methods")

local FORMATTING = methods.internal.FORMATTING

return h.make_builtin({
    name = "JuliaFormatter",
    meta = {
        url = "https://github.com/domluna/JuliaFormatter.jl",
        description = "The uncompromising Python code formatter.",
    },
    method = FORMATTING,
    filetypes = { "julia" },
    generator_opts = {
        command = "julia",
        args = {
            "-e",
            "using JuliaFormatter; println(format_text(String(read(stdin))))",
        },
        to_stdin = true,
    timeout = 30000,
    },
    factory = h.formatter_factory,
})
