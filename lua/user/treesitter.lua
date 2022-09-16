local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

-- fold settings
-- vim.wo.foldmethod = "expr"
-- vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.wo.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').''.trim(getline(v:foldend)) ]]
-- vim.wo.fillchars = "fold:\\"
-- vim.wo.foldnestmax = 3
-- vim.wo.foldminlines = 1

configs.setup({
  ensure_installed = { -- one of "all" or a list of languages
    "bash",
    "c",
    "c_sharp",
    "comment",
    "cpp",
    "css",
    "dockerfile",
    "go",
    "html",
    "http",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "lua",
    "python",
    "rust",
    "scss",
    "svelte",
    "toml",
    "tsx",
    "tsx",
    "typescript",
    "vim",
    "vue",
    "yaml",
  },
  ignore_install = { "" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "css" }, -- list of language that will be disabled
  },
  autopairs = {
    enable = true,
  },
  indent = { enable = true, disable = { "python", "css" } },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  },
})
