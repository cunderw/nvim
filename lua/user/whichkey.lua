local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["f"] = {
    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Find files",
  },
  ["F"] = { require 'telescope.builtin'.live_grep, "Find Text" },
  ["P"] = { require 'telescope'.load_extension('projects').projects, "Projects" },
  ["?"] = { "<cmd>Cheatsheet<cr>", "Cheatsheet" },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { require 'gitsigns'.next_hunk, "Next Hunk" },
    k = { require 'gitsigns'.prev_hunk, "Prev Hunk" },
    l = { require 'gitsigns'.blame_line, "Blame" },
    p = { require 'gitsigns'.preview_hunk, "Preview Hunk" },
    r = { require 'gitsigns'.reset_hunk, "Reset Hunk" },
    R = { require 'gitsigns'.reset_buffer, "Reset Buffer" },
    s = { require 'gitsigns'.stage_hunk, "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { require 'telescope.builtin'.git_status, "Open changed file" },
    b = { require 'telescope.builtin'.git_branches, "Checkout branch" },
    c = { require 'telescope.builtin'.git_commits, "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },

  s = {
    name = "Search",
    b = { require 'telescope.builtin'.git_branches, "Checkout branch" },
    c = { require 'telescope.builtin'.colorscheme, "Colorscheme" },
    h = { require 'telescope.builtin'.help_tags, "Find Help" },
    M = { require 'telescope.builtin'.man_pages, "Man Pages" },
    r = { require 'telescope.builtin'.oldfiles, "Open Recent File" },
    R = { require 'telescope.builtin'.registers, "Registers" },
    k = { require 'telescope.builtin'.keymaps, "Keymaps" },
    C = { require 'telescope.builtin'.commands, "Commands" },
  },

  t = {
    name = "Terminal",
    n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },

  v = {
    name = "Vimspector",
    I = { "<cmd>VimspectorInstall<cr>", "Install" },
    U = { "<cmd>VimspectorUpdate<cr>", "Update" },
    R = { "<cmd>call vimspector#RunToCursor()<cr>", "Run to Cursor" },
    c = { "<cmd>call vimspector#Continue()<cr>", "Continue" },
    i = { "<cmd>call vimspector#StepInto()<cr>", "Step Into" },
    o = { "<cmd>call vimspector#StepOver()<cr>", "Step Over" },
    s = { "<cmd>call vimspector#Launch()<cr>", "Start" },
    t = { "<cmd>call vimspector#ToggleBreakpoint()<cr>", "Toggle Breakpoint" },
    u = { "<cmd>call vimspector#StepOut()<cr>", "Step Out" },
    S = { "<cmd>call vimspector#Stop()<cr>", "Stop" },
    r = { "<cmd>call vimspector#Restart()<cr>", "Restart" },
    x = { "<cmd>VimspectorReset<cr>", "Reset" },
    H = { "<cmd>lua require('config.vimspector').toggle_human_mode()<cr>", "Toggle HUMAN mode" },
  },

  l = {
    name = "LSP",
    D = { vim.lsp.buf.declaration, "Goto Declaration" },
    H = { vim.lsp.buf.signature_help, "Signature Help" },
    R = { require 'telescope.builtin'.lsp_references, "References" },
    S = { require 'telescope.builtin'.lsp_workspace_symbols, "Workspace Symbols" },
    a = { vim.lsp.buf.code_action, "Code Action" },
    d = { require 'telescope.builtin'.lsp_definitions, "Goto Definition" },
    f = { vim.lsp.buf.formatting, "Format" },
    h = { vim.lsp.buf.hover, "Hover" },
    i = { require 'telescope.builtin'.lsp_implementations, "Implimentations" },
    j = { vim.diagnostic.goto_next, "Next Diagnostic" },
    k = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
    l = { vim.lsp.codelens.run, "CodeLens Action" },
    q = { require 'telescope.builtin'.quickfix, "Quickfix" },
    r = { vim.lsp.buf.rename, "Rename" },
    s = { require 'telescope.builtin'.lsp_document_symbols, "Document Symbols" },
    t = { require 'telescope.builtin'.lsp_type_definitions, "Type Definition" },
    w = { require 'telescope.builtin'.diagnostics, "Diagnostics" },
    P = {
      name = "Peek",
      d = { "<cmd>lua require('user.lsp.peek').Peek('definition')<cr>", "Definition" },
      t = { "<cmd>lua require('user.lsp.peek').Peek('typeDefinition')<cr>", "Type Definition" },
      i = { "<cmd>lua require('user.lsp.peek').Peek('implementation')<cr>", "Implementation" },
    },
  },

  b = {
    name = "Buffers",
    j = { "<cmd>BufferLinePick<cr>", "Jump" },
    f = { require 'telescope.builtin'.buffers, "Find" },
    b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
    n = { "<cmd>BufferLineCycleNext<cr>", "Next" },
    e = {
      "<cmd>BufferLinePickClose<cr>",
      "Pick which buffer to close",
    },
    h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
    l = {
      "<cmd>BufferLineCloseRight<cr>",
      "Close all to the right",
    },
    D = {
      "<cmd>BufferLineSortByDirectory<cr>",
      "Sort by directory",
    },
    L = {
      "<cmd>BufferLineSortByExtension<cr>",
      "Sort by language",
    },
  },


  n = {
    name = "Navigation",
    h = { "<cmd>HopWord<cr>", "Hop" },
    o = { "<cmd>SymbolsOutline<cr>", "Outline" },
  },

  S = {
    name = "Session",
    c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
    l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
    Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
  },
}

which_key.setup(setup)
which_key.register(mappings, opts)
