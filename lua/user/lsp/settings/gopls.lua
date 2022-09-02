local status_ok, ih = pcall(require, "inlay-hints")

if not status_ok then
  return
end

return {
	on_attach = function(c, b)
		ih.on_attach(c, b)
	end,
	settings = {
		gopls = {
			env = { GOFLAGS = "-tags=integration" },
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},
}
