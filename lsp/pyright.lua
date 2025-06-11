local function get_python_executable()
	local venv_path = os.getenv("VIRTUAL_ENV")
	if venv_path then
		return venv_path .. "/bin/python"
	else
		return "python" -- Default to system python if VIRTUAL_ENV is not set
	end
end

return {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	opts = {
		before_init = function(params)
			params.processId = vim.NIL
			params.rootPath = vim.fn.getcwd()
			params.rootUri = vim.uri_from_fname(vim.fn.getcwd())
			params.initializationOptions = { pythonPath = get_python_executable() }
		end,
		settings = {
			python = {
				pythonPath = get_python_executable(),
				typeCheckingMode = "strict",
				analyzeUnannotatedFunctions = false,
				reportReturnType = true,
				diagnosticMode = "openFilesOnly",
				useLibraryCodeForTypes = true,
			},
		},
	},
}
