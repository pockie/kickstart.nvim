# Neovim Configuration

A modular Neovim configuration based on ['kickstart.nvim'](https://github.com/nvim-lua/kickstart.nvim).

## Installation

### Install Neovim

Kickstart.nvim targets *only* the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.
If you are experiencing issues, please make sure you have at least the latest
stable version. Most likely, you want to install neovim via a [package
manager](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-package).
To check your neovim version, run `nvim --version` and make sure it is not
below the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) version. If
your chosen install method only gives you an outdated version of neovim, find
alternative [installation methods below](#alternative-neovim-installation-methods).

### Install External Dependencies

External Requirements:
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation),
  [fd-find](https://github.com/sharkdp/fd#installation)
- [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md#installation)
- Clipboard tool (xclip/xsel/win32yank or other depending on the platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true
- Emoji fonts (Ubuntu only, and only if you want emoji!) `sudo apt install fonts-noto-color-emoji`
- Language Setup:
  - If you want to write Typescript, you need `npm`
  - If you want to write Golang, you will need `go`
  - etc.

> [!NOTE]
> See [Install Recipes](#Install-Recipes) for additional Windows and Linux specific notes
> and quick install snippets

### Install Kickstart

Neovim's configurations are located under the following paths, depending on your OS:

| OS | PATH |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)| `%localappdata%\nvim\` |
| Windows (powershell)| `$env:LOCALAPPDATA\nvim\` |


#### Recommended Step

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) this repo
so that you have your own copy that you can modify, then install by cloning the
fork to your machine using one of the commands below, depending on your OS.

> [!NOTE]
> Your fork's URL will be something like this:
> `https://github.com/<your_github_username>/kickstart.nvim.git`

You likely want to remove `lazy-lock.json` from your fork's `.gitignore` file
too - it's ignored in the kickstart repo to make maintenance easier, but it's
[recommended to track it in version control](https://lazy.folke.io/usage/lockfile).

#### Clone kickstart.nvim

```sh
git clone https://github.com/your-username/nvim-config.git ~/.config/nvim
```

## Project Structure

```
nvim/
├── init.lua                    # Main entry point
├── lua/
│   ├── core/                  # Core configurations
│   │   ├── options.lua         # Basic options
│   │   ├── keymaps.lua        # Keybindings
│   │   └── autocmds.lua       # Autocommands
│   ├── lsp/                    # LSP configuration
│   │   ├── init.lua           # Main setup + Mason
│   │   ├── handlers.lua       # LspAttach keymaps
│   │   ├── diagnostics.lua    # Diagnostic config
│   │   └── servers/           # Per-server configs
│   │       ├── lua_ls.lua
│   │       ├── ts_ls.lua
│   │       └── ...
│   └── plugins/                # Plugin configurations
│       ├── init.lua           # Plugin imports
│       ├── telescope.lua
│       ├── lspconfig.lua
│       └── ...
└── README.md
```

## Adding Plugins

1. Create file in `lua/plugins/` (e.g., `my-plugin.lua`)
2. Return plugin spec:
```lua
return {
  'username/plugin-name',
  event = 'VimEnter',
  config = function()
    -- configuration
  end,
}
```
3. Add to `lua/plugins/init.lua`:
```lua
require('plugins.my-plugin'),
```

## Adding Language Servers

1. Create file in `lua/lsp/servers/` (e.g., `pyright.lua`)
2. Return server config:
```lua
return {
  settings = {
    -- server-specific settings
  },
}
```
3. Install with `:Mason`

## Getting Help

- `:help` - Neovim documentation
- `:Lazy` - Plugin manager
- `:checkhealth` - Health checks
- `<leader>sh` - Search help with Telescope
