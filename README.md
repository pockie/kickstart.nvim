# Neovim Configuration

A modular Neovim configuration based on kickstart.nvim.

## Installation

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
