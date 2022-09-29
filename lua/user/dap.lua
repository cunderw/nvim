local dap_status_ok, dap = pcall(require, "dap")

if not dap_status_ok then
  return
end

local icons = require("user.icons")

vim.fn.sign_define("DapBreakpoint", { text = icons.ui.Bug, texthl = "DiagnosticSignError", linehl = "", numhl = "" })

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
