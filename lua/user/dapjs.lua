local dapjs_status_ok, dapjs = pcall(require, "dap-vscode-js")

if not dapjs_status_ok then
  return
end

local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

dapjs.setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
  adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
})

-- Default configurations
local defaults = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Node Launch",
    program = "${file}",
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
    resolveSourceMapLocations = {
      "${workspaceFolder}/dist/**/*.js",
      "${workspaceFolder}/**",
      "!**/node_modules/**",
    },
    runtimeExecutable = "${workspaceFolder}/node_modules/.bin/ts-node",
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Node Attach",
    processId = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
    resolveSourceMapLocations = {
      "${workspaceFolder}/dist/**/*.js",
      "${workspaceFolder}/**",
      "!**/node_modules/**",
    },
  },
  {
    type = "pwa-node",
    request = "launch",
    name = "Debug Jest Tests",
    -- trace = true, -- include debugger info
    runtimeExecutable = "node",
    runtimeArgs = {
      "./node_modules/jest/bin/jest.js",
      "--runInBand",
    },
    rootPath = "${workspaceFolder}",
    cwd = "${workspaceFolder}",
    console = "integratedTerminal",
    internalConsoleOptions = "neverOpen",
  },
}
for _, language in ipairs({ "typescript", "javascript" }) do
  if dap.configurations[language] == nil then
    dap.configurations[language] = {}
  end
  vim.list_extend(dap.configurations[language], defaults)
end
