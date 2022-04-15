# neovim-config

Followed the Youtube series of [neovim from scratch](https://www.youtube.com/playlist?list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIz). Here are some notes I took :)

To install just clone the repository into `~/.config/nvim/`

Execute `:LSPInstall` to install LspClients

### notes

We are using lua, that means we have the configuration spread around the files, and importing them
in the init.lua


#### What are AutoCmd

Are scripts that can be executed when specific events happens, for example we could 
set to reload the plugins, each time the plugins.lua is saved.

checkout `:help autcmd` for more info and events to subscribe.

#### What is packer

Packer is a plugin to manager plugins, it enable you to download plugins for vim from other github repositories

#### What is a NerdFont

NerdFont are patched programming fonts like `CodeFira` etc... where they add all the icons from a lot of "icon" fonts out there

Take a look to https://www.nerdfonts.com/

#### What is cmp

Is a plugin for having autocompletion from a lot of different sources like
- path: files in the filesystem
- buffer: occurrences from the current buffer
- snippets
- LSP 

#### LSP more info

`:LSPInstall` => To install new LSP clients and servers
`:LspInfo` => Show wich LSP client is working

Keybindings
===========

- `gl` -> show error in current cursor
- `gd` -> go to definition
- `gi` -> go to implementation
- `C-k` -> Show documentation
- `gr` -> go to references
- `[d` -> go to prev diagnostic
- `]d` -> go to next diagnostic

#### Telescope

Telescope is a plugin that permits you to fuzzy search like...

- `Space-f` => Find files
- `Space-t` Search in files
- Search branches etc....


#### TreeSitter

TreeSitter allow you to load better syntax parsers for files. For example vim doesn't parse correctly JSX etc...


#### Comments

- `M+/` => Comment lines in normal mode and in visual mode

#### Tree

- `Space-e` -> Shows the tree on the side

With the focus of the tree...

- `d` -> delete file
- `r` -> rename file
- `a` -> create file

#### Magit

- `Space-g` -> Magit
