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

  -- Editor Utils
  use({ "JoosepAlviste/nvim-ts-context-commentstring" })
  use({ "itchyny/vim-highlighturl", event = "BufRead" })
  use({ "karb94/neoscroll.nvim" })
  use({ "lukas-reineke/indent-blankline.nvim" })
  use({ "norcalli/nvim-colorizer.lua" })
  use({ "numToStr/Comment.nvim" })
  use({ "nvim-treesitter/nvim-treesitter" })
  use({ "p00f/nvim-ts-rainbow" })
  use({ "preservim/vimux" })
  use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter
  use({ 'phaazon/hop.nvim', branch = 'v2' })
  use({ 'simrat39/symbols-outline.nvim' })
  use({ 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' })
  use({
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu',
  })
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
  use({ "tversteeg/registers.nvim" })
  use({ "vimpostor/vim-tpipeline" })

  -- Colorschemes
  use({ "folke/tokyonight.nvim" })

  -- Completion plugins
  use({ "hrsh7th/cmp-buffer" }) -- buffer completions
  use({ "hrsh7th/cmp-cmdline" }) -- cmdline completions
  use({ "hrsh7th/cmp-emoji" })
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-nvim-lua" })
  use({ "hrsh7th/cmp-path" }) -- path completions
  use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
  use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions

  -- snippets
  use({ "L3MON4D3/LuaSnip" }) --snippet engine
  use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

  -- LSP
  use({ "neovim/nvim-lspconfig" }) -- enable LSP
  use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
  use({ "williamboman/nvim-lsp-installer" })
  -- Cannot make work reliably yet
  -- use({ "williamboman/mason.nvim" })
  -- use({ "williamboman/mason-lspconfig.nvim" })
  use({ "ray-x/lsp_signature.nvim" })

  -- Telescope
  use({ "nvim-telescope/telescope.nvim" })

  -- Treesitter

  -- Git
  use({ "lewis6991/gitsigns.nvim" })
  use({ "f-person/git-blame.nvim" })
  use({ "ruifm/gitlinker.nvim" })
  use({ "mattn/vim-gist" })
  use({ "mattn/webapi-vim" })

  -- Java
  use({ "mfussenegger/nvim-jdtls" })

  -- Debug
  use({ "mfussenegger/nvim-dap" })
  use({ "rcarriga/nvim-dap-ui" })
  use({
    "puremourning/vimspector", -- Visual debugging
    cmd = { "VimspectorInstall", "VimspectorUpdate" },
    fn = { "vimspector#Launch()", "vimspector#ToggleBreakpoint", "vimspector#Continue" },
  })

  -- Golang
  use({ "benmills/vimux-golang" })
  use({ "fatih/vim-go" })
  use({ "rfratto/vim-go-testify" })
  use({ "sebdah/vim-delve" })

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
