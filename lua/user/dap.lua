local dap_status_ok, dap = pcall(require, "dap")

if not dap_status_ok then
  return
end

local icons = require("user.icons")

vim.fn.sign_define("DapBreakpoint", { text = icons.ui.Bug, texthl = "DiagnosticSignError", linehl = "", numhl = "" })


-- Go DAP
dap.adapters.go = {
  type = 'executable';
  command = 'node';
  args = { os.getenv('HOME') .. '/.local/share/nvim/site/pack/packer/opt/vscode-go/dist/debugAdapter.js' };
}

dap.configurations.go = {
  {
    type = 'go';
    name = 'debug';
    request = 'launch';
    showLog = false;
    program = "${file}";
  }
}

-- Chrome DAP
dap.adapters.chrome = {
  type = "executable",
  command = "node",
  args = { os.getenv("HOME") .. "/.local/share/nvim/site/pack/packer/opt/vscode-chrome-debug/out/src/chromeDebug.js" } -- TODO adjust
}

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = { os.getenv('HOME') .. '/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js' },
}

dap.adapters.reactnative = {
  type = 'executable',
  command = 'node',
  args = { os.getenv('HOME') .. '/dev/microsoft/vscode-react-native/src/debugger/rnDebugSession.ts' },
}

-- Setup launch.json loading
local ts_file_types = {
  'typescriptreact',
  'typescript',
  'javascript',
  'javascriptreact',
}

local go_file_types = {
  'go'
}

local java_file_types = {
  'java'
}

local launch_types = {
  node = ts_file_types,
  node2 = ts_file_types,
  ["node-terminal"] = ts_file_types,
  ["pwa-node"] = ts_file_types,
  ["pwa-chrome"] = ts_file_types,
  ["chrome"] = ts_file_types,
  reactnativedirect = ts_file_types,
  reactnative = ts_file_types,
  go = go_file_types,
  java = java_file_types
}

local load_launchjs = function()
  require("dap.ext.vscode").load_launchjs(nil, launch_types)
end
if not pcall(load_launchjs) then
  vim.notify("Failed to parse launch.json", vim.log.levels.WARN)
end

-- Adds dlv path to all added configuration, setting it in laun.json does not work
for _, config in pairs(dap.configurations["go"]) do
  config["dlvToolPath"] = vim.fn.exepath(os.getenv('HOME') .. '/go/bin/dlv') -- Adjust to where delve is installed
end

-- Setup events
local status_ok, dapui = pcall(require, "dapui")
if not status_ok then
  return
end

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  -- dapui.close {}
end
dap.listeners.before.event_exited["dapui_config"] = function()
  -- dapui.close {}
end
