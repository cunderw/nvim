local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local vopts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  L = {
    name = "Go",
    t = { "<cmd>lua require('dap-go').debug_test()<cr>", "Debug test" },
    f = { "<cmd>GoFormat<cr>", "Go Format" },
    T = { "<cmd>GoTest<cr>", "Go Test" },
    G = { "<cmd>GoGet<cr>", "Go Get" },
    I = { "<cmd>GoImport<cr>", "Go Import" },
  },
}

local vmappings = {
  L = {
    name = "Go",
    t = { "<cmd>lua require('dap-go').debug_test()<cr>", "Debug test" },
    f = { "<cmd>GoFormat<cr>", "Go Format" },
    T = { "<cmd>GoTest<cr>", "Go Test" },
    G = { "<cmd>GoGet<cr>", "Go Get" },
    I = { "<cmd>GoImport<cr>", "Go Import" },
  },
}

which_key.register(mappings, opts)
which_key.register(vmappings, vopts)


local file_types = {
  'go'
}

local launch_types = {
  go = file_types
}


local load_launchjs = function()
  require("dap.ext.vscode").load_launchjs(nil, launch_types)
end
if not pcall(load_launchjs) then
  vim.notify("Failed to parse launch.json", "warn")
end
