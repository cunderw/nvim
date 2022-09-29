local file_types = {
  'typescriptreact',
  'typescript'
}

local launch_types = {
  node = file_types
}

launch_types["node-terminal"] = file_types
launch_types["pwa-node"] = file_types
launch_types["pwa-chrome"] = file_types

local load_launchjs = function()
  require("dap.ext.vscode").load_launchjs(nil, launch_types)
end
if not pcall(load_launchjs) then
  vim.notify("Failed to parse launch.json", "warn")
end
