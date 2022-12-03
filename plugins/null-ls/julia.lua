local h = require("null-ls.helpers")
local methods = require("null-ls.methods")

return {
    method = methods.internal.FORMATTING,
    name = "JuliaFormatter",
    meta = {
        url = "https://github.com/domluna/JuliaFormatter.jl",
        description = "An opinionated code formatter for Julia.",
    },
    filetypes = { "julia" },
    generator = h.formatter_factory {
        command = "juliafmt",
        to_stdin = true,
    }
}
