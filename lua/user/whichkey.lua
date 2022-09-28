local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

require('legendary').setup()

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
  ["o"] = { "<cmd>Legendary<cr>", "Legendary" },
  ["C"] = { "<cmd>lua require('telescope').extensions.neoclip.default()<cr>", "Neoclip" },
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
  ["F"] = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Find Text" },
  ["P"] = { "<cmd>lua require('telescope').load_extension('projects').projects()<cr>", "Projects" },
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
    j = { "<cmd>lua require('gitsigns').next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require('gitsigns').prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require('gitsigns').blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require('gitsigns').preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require('gitsigns').reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require('gitsigns').reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require('gitsigns').stage_hunk()<cr>", "Stage Hunk" },
    u = { "<cmd>lua require('gitsigns').undo_stage_hunk()<cr>", "Undo Stage Hunk" },
    o = { "<cmd>lua require('telescope.builtin').git_status()<cr>", "Open changed file" },
    b = { "<cmd>lua require('telescope.builtin').git_branches()<cr>", "Checkout branch" },
    c = { "<cmd>lua require('telescope.builtin').git_commits()<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
    D = {
      name = "Diffview",
      o = { "<cmd>DiffviewOpen", "Diffview Open" },
      c = { "<cmd>DiffviewClose", "Diffview Close" }
    }
  },

  s = {
    name = "Search",
    b = { "<cmd>lua require('telescope.builtin').git_branches()<cr>", "Checkout branch" },
    c = { "<cmd>lua require('telescope.builtin').colorscheme()<cr>", "Colorscheme" },
    h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Find Help" },
    M = { "<cmd>lua require('telescope.builtin').man_pages()<cr>", "Man Pages" },
    r = { "<cmd>lua require('telescope.builtin').oldfiles()<cr>", "Open Recent File" },
    R = { "<cmd>lua require('telescope.builtin').registers()<cr>", "Registers" },
    k = { "<cmd>lua require('telescope.builtin').keymaps()<cr>", "Keymaps" },
    C = { "<cmd>lua require('telescope.builtin').commands()<cr>", "Commands" },
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


  l = {
    name = "LSP",
    D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto Declaration" },
    H = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
    R = { "<cmd>lua require('telescope.builtin').lsp_references()<cr>", "References" },
    S = { "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>", "Workspace Symbols" },
    a = { "<cmd>CodeActionMenu<cr>", "Code Action" },
    d = { "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", "Goto Definition" },
    f = { "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format" },
    h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
    i = { "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>", "Implimentations" },
    j = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
    k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua require('telescope.builtin').quickfix()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", "Document Symbols" },
    t = { "<cmd>lua require('telescope.builtin').lsp_type_definitions()<cr>", "Type Definition" },
    w = { "<cmd>lua require('telescope.builtin').diagnostics()<cr>", "Diagnostics" },
    o = { "<cmd>SymbolsOutline<cr>", "Outline" },
    P = {
      name = "Peek",
      d = { "<cmd>lua require('user.lsp.peek').Peek('definition')<cr>", "Definition" },
      t = { "<cmd>lua require('user.lsp.peek').Peek('typeDefinition')<cr>", "Type Definition" },
      i = { "<cmd>lua require('user.lsp.peek').Peek('implementation')<cr>", "Implementation" },
    },
    T = {
      name = "Trouble",
      t = { "<cmd>TroubleToggle<cr>", "Toggle" },
      w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
      d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
      q = { "<cmd>TroubleToggle quickfix<cr>", "QuickFix" },
      l = { "<cmd>TroubleToggle loclist<cr>", "Loc List" },
      L = { "<cmd>TroubleToggle lsp_references<cr>", "Reference" },
    },
  },

  b = {
    name = "Buffers",
    j = { "<cmd>BufferLinePick<cr>", "Jump" },
    f = { require("telescope.builtin").buffers, "Find" },
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
    t = { "<cmd>tabnew<cr>", "New Tab" },
    n = { "<cmd>tabn<cr>", "Next Tab" },
    p = { "<cmd>tabp<ncr>", "Previous Tab" },
    c = { "<cmd>tabclose<cr>", "Close Tab" },
  },

  S = {
    name = "Session",
    c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
    l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
    Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
  },

  d = {
    name = "Debug",
    b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
    O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
    l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
    u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
    x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
  },

  z = {
    name = "Zen",
    a = { "<cmd>TZAtaraxis<cr>", "Ataraxis" },
    m = { "<cmd>TZMinimalist<cr>", "Minimalist" },
    n = { "<cmd>TZNarrow<cr>", "Narrow" },
    f = { "<cmd>TZFocus<cr>", "Focus" },
  },
}

which_key.setup(setup)
which_key.register(mappings, opts)

--local l_status_ok, legendary = pcall(require, "legendary")
--if not l_status_ok then
--  return
--end
--
--legendary.setup({
--  which_key = {
--    mappings = mappings,
--    opts = opts,
--    do_binding = false,
--  },
--})
