return {
    settings = {
        Lua = {
            runtime = {version = "LuaJIT"},
            diagnostics = {globals = {"vim"}},
            format = {enable = false},
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
            },
            telemetry = {enable = false},
        },
    },
}
