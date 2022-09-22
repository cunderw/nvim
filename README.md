# My Neovim Config
Generated fromn [Neovim-from-scratch](https://github.com/LunarVim/Neovim-from-scratch)

## Try out this config

Make sure to remove or move your current `nvim` directory

**IMPORTANT** Requires [Neovim v0.8.0]](https://github.com/neovim/neovim/releases).  [Upgrade](#upgrade-to-latest-release) if you're on an earlier version. 
```
git clone https://github.com/cunderw/nvim.git ~/.config/nvim
```

Run `nvim` and wait for the plugins to be installed 

**NOTE** (You will notice treesitter pulling in a bunch of parsers the next time you open Neovim) 

## Get healthy

Open `nvim` and enter the following:

```
:checkhealth
```

You'll probably notice you don't have support for copy/paste also that python and node haven't been setup

So let's fix that

First we'll fix copy/paste

- On mac `pbcopy` should be builtin

- On Ubuntu

  ```
  sudo apt install xsel
  ```

- On Arch Linux

  ```
  sudo pacman -S xsel
  ```

Next we need to install python support (node is optional)

- Neovim python support

  ```
  pip install pynvim
  ```

- Neovim node support

  ```
  npm i -g neovim
  ```
---

## Java Development Setup 

This should be handled by packer now, leaving documented for now.

Please run the following to have a better debugging and testing support for java

```shell
git clone git@github.com:microsoft/java-debug.git ~/.config/lvim/java-debug
cd ~/.config/lvim/java-debug/
./mvnw clean install
git clone git@github.com:microsoft/vscode-java-test.git ~/.config/lvim/vscode-java-test
cd ~/.config/lvim/vscode-java-test
npm install
npm run build-plugin
```

## Lua

```shell
brew install rust
cargo install stylua
```

## Bash/Zsh 

```shell
pip install beautysh
```
