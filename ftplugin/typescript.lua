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
    name = "Typescript",
    a = { "<cmd>TypescriptAddMissingImports<cr>", "Add Missing Imports" },
    o = { "<cmd>TypescriptOrganizeImports<cr>", "Organize Imports" },
    r = { "<cmd>TypescriptRemoveUnused<cr>", "Remove Unused Vars" },
    f = { "<cmd>TypescriptFixAll<cr>", "Fix All" },
    R = { "<cmd>TypescriptRenameFile<cr>", "Rename File" },
    d = { "<cmd>TypescriptGoToSourceDefinition<cr>", "Goto Definition" },
  },
}

local vmappings = {
  L = {
    name = "Typescript",
    a = { "<cmd>TypescriptAddMissingImports<cr>", "Add Missing Imports" },
    o = { "<cmd>TypescriptOrganizeImports<cr>", "Organize Imports" },
    r = { "<cmd>TypescriptRemoveUnused<cr>", "Remove Unused Vars" },
    f = { "<cmd>TypescriptFixAll<cr>", "Fix All" },
    R = { "<cmd>TypescriptRenameFile<cr>", "Rename File" },
    d = { "<cmd>TypescriptGoToSourceDefinition<cr>", "Goto Definition" },
  },
}

which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
