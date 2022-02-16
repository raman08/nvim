local dap = require('dap')
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/raman/.vscode/extensions/ms-vscode.cpptools-1.8.4/debugAdapters/bin/OpenDebugAD7',
}

	-- "name": "g++ - Build and debug active file",
	-- "type": "cppdbg",
	-- "request": "launch",
	-- "program": "${fileDirname}/${fileBasenameNoExtension}",
	-- "args": [],
	-- "stopAtEntry": false,
	-- "cwd": "${fileDirname}",
	-- "environment": [],
	-- "externalConsole": false,
	-- "MIMode": "gdb",
	-- "setupCommands": [
	-- 	{
	-- 		"description": "Enable pretty-printing for gdb",
	-- 		"text": "-enable-pretty-printing",
	-- 		"ignoreFailures": true
	-- 	},
	-- 	{
	-- 		"description": "Set Disassembly Flavor to Intel",
	-- 		"text": "-gdb-set disassembly-flavor intel",
	-- 		"ignoreFailures": true
	-- 	}
	-- ],
	-- "preLaunchTask": "C/C++: g++ build active file",
	-- "miDebuggerPath": "/usr/bin/gdb"
dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "cppdbg",
		request = "launch",
		program = function()
		return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = true,
	},
	{
		name = 'Attach to gdbserver :1234',
		type = 'cppdbg',
		request = 'launch',
		MIMode = 'gdb',
		miDebuggerServerAddress = 'localhost:1234',
		miDebuggerPath = '/usr/bin/gdb',
		cwd = '${workspaceFolder}',
		program = function()
		return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
	},
}
