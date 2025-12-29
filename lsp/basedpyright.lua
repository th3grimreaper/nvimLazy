return {
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
	settings = {
		basedpyright = {
			analysis = {
				typeCheckingMode = "off",
				reportUnknownArgumentType = "none",
				reportUnknownParameterType = "none",
				reportUnknownMemberType = "none",
				allowedUntypedLibraries = { "library", "module.submodule" },
			},
		},
	},
}
