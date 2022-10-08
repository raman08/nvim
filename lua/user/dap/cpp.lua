local status_dap_ok, dap = pcall(require, "dap")
if not status_dap_ok then return end

-- setup clangd
-- customize clangd by changing the flags below
local clangd_flags = {
    "--background-index",
    "--fallback-style=google",
    "--all-scopes-completion",
    "--clang-tidy",
    "--log=error",
    "--completion-style=detailed",
    "--pch-storage=disk",
    "--folding-ranges",
    "--enable-config",
}

dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        -- CHANGE THIS to your path!
        command = "codelldb",
        args = {"--port", "${port}"},

        -- On windows you may have to uncomment this:
        -- detached = false,
    },
}

dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/",
                                "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    },
}

dap.configurations.c = dap.configurations.cpp
