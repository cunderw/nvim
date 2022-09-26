local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

return packer.startup(function(use)
  use({ "wbthomason/packer.nvim" }) -- Have packer manage itself

  -- Appearance
  use({ "akinsho/bufferline.nvim" })
  use({ "kyazdani42/nvim-web-devicons" })
  use({ "nvim-lualine/lualine.nvim" })
  use({ "folke/tokyonight.nvim" })
  use({ "tiagovla/tokyodark.nvim" })

  -- Editor Utils
  use({ "JoosepAlviste/nvim-ts-context-commentstring" })
  use({ "itchyny/vim-highlighturl", event = "BufRead" })
  use({ "karb94/neoscroll.nvim" })
  use({ "lukas-reineke/indent-blankline.nvim" })
  use({ "norcalli/nvim-colorizer.lua" })
  use({ "numToStr/Comment.nvim" })
  use({ "nvim-treesitter/nvim-treesitter" })
  use({ "p00f/nvim-ts-rainbow" })
  use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter
  use({ "phaazon/hop.nvim", branch = "v2" })
  use({ "simrat39/symbols-outline.nvim" })
  use({ "simrat39/inlay-hints.nvim" })
  use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
  use({ "RRethy/vim-illuminate" })
  use({
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
  })
  use({
    "sudormrfbin/cheatsheet.nvim",
    requires = {
      { "nvim-telescope/telescope.nvim" },
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
  })
  use({ "gennaro-tedesco/nvim-peekup" })
  use({ 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' })

  -- Projects / Sessions
  use({ "folke/persistence.nvim", event = "BufReadPre", module = "persistence" })
  use({ "ahmedkhalf/project.nvim" })

  -- Misc utils
  use({ "akinsho/toggleterm.nvim" })
  use({ "christoomey/vim-tmux-navigator" })
  use({ "folke/which-key.nvim" })
  use({ "goolord/alpha-nvim" })
  use({ "kyazdani42/nvim-tree.lua" })
  use({ "lewis6991/impatient.nvim" })
  use({ "moll/vim-bbye" })
  use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
  use({ "rcarriga/nvim-notify" })
  use({ "vimpostor/vim-tpipeline" })
  use({ "tiagovla/scope.nvim" })


  -- Completion plugins
  use({ "hrsh7th/cmp-buffer" }) -- buffer completions
  use({ "hrsh7th/cmp-cmdline" }) -- cmdline completions
  use({ "hrsh7th/cmp-emoji" })
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-nvim-lua" })
  use({ "hrsh7th/cmp-path" }) -- path completions
  use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
  use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions

  -- Snippets
  use({ "L3MON4D3/LuaSnip" }) --snippet engine
  use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

  -- LSP
  use({ "neovim/nvim-lspconfig" }) -- enable LSP
  use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
  use({ "williamboman/nvim-lsp-installer" })
  use({ "ray-x/lsp_signature.nvim" })
  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
  })

  -- Telescope
  use({ "nvim-telescope/telescope.nvim" })

  -- Git
  use({ "lewis6991/gitsigns.nvim" })
  use({ "f-person/git-blame.nvim" })
  use({ "ruifm/gitlinker.nvim" })
  use({ "mattn/vim-gist" })
  use({ "mattn/webapi-vim" })

  -- Java
  use({ "mfussenegger/nvim-jdtls" })
  use({
    "microsoft/java-debug",
    opt = true,
    run = "mvn clean install",
  })
  use({
    "microsoft/vscode-java-test",
    opt = true,
    run = "npm install && npm run build-plugin",
  })

  -- Debug
  use({ "mfussenegger/nvim-dap" })
  use({ "rcarriga/nvim-dap-ui" })
  use({ "theHamsta/nvim-dap-virtual-text" })
  use({
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-go",
    },
  })

  -- Golang
  use({ "crispgm/nvim-go" })
  use({ "fatih/vim-go" })
  use({ "leoluz/nvim-dap-go" })
  use({ "rfratto/vim-go-testify" })

  -- Typescript
  use({ "jose-elias-alvarez/typescript.nvim" })
  use({
    "microsoft/vscode-js-debug",
    opt = true,
    run = "npm install --legacy-peer-deps && npm run compile"
  })
  use({
    "mxsdev/nvim-dap-vscode-js",
    requires = { "mfussenegger/nvim-dap" }
  })
  use({ "MunifTanjim/eslint.nvim" })

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
