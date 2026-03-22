# AGENTS.md

This file contains guidelines for agentic coding agents working on this Neovim configuration repository.

## Repository Overview

This is a Kickstart.nvim-based Neovim configuration using Lua as the primary language. The configuration follows a modular architecture with lazy.nvim as the plugin manager.

## Build/Lint/Test Commands

### Code Formatting
```bash
# Check formatting without making changes
stylua --check .

# Format all Lua files
stylua .

# Format specific file
stylua path/to/file.lua
```

### Health Checks
```vim
:checkhealth  " Run Neovim health checks
```

### Plugin Management
```vim
:Lazy         " Open lazy.nvim interface
:Lazy sync    " Sync all plugins
:Lazy clean   " Clean unused plugins
```

## Code Style Guidelines

### Lua Formatting (Stylua)
- **Indentation**: 2 spaces
- **Line width**: 160 characters
- **Quotes**: Single quotes preferred (`AutoPreferSingle`)
- **Function calls**: No trailing parentheses (`call_parentheses = "None"`)

### File Organization
```
lua/kickstart/plugins/     # Core plugin configurations
lua/custom/plugins/        # User customizations
init.lua                   # Main configuration file
```

### Plugin Configuration Pattern
```lua
return {
  'plugin/repo',
  dependencies = { 'dependency1', 'dependency2' },
  config = function()
    -- Plugin configuration
  end,
  keys = { '<leader>k', mode = 'n' },
  event = { 'BufReadPre' },
  opts = {
    -- Plugin options
  },
}
```

### Import Conventions
- Use `require()` for module imports
- Local imports at top of files: `local plugin = require('plugin')`
- Prefer lazy loading via `event`, `keys`, `cmd` in plugin specs

### Naming Conventions
- **Files**: kebab-case (`auto-pairs.lua`, `git-signs.lua`)
- **Variables**: snake_case (`local_key_map`, `plugin_config`)
- **Functions**: snake_case (`setup_plugin()`, `handle_keybind()`)
- **Constants**: UPPER_SNAKE_CASE (`DEFAULT_TIMEOUT`, `MAX_BUFFER_SIZE`)

### Documentation Style
- Use `--` for single-line comments
- Use `--[[ ]]` for multi-line comment blocks
- Include `:help` references for Neovim functions
- Use `NOTE:`, `TODO:`, `WARNING:` markers for important information

### Error Handling
- Use `pcall()` for safe function calls
- Check for nil values before table access
- Provide fallback configurations for optional features

## Configuration Patterns

### Key Mapping
```lua
vim.keymap.set('n', '<leader>ff', function()
  require('telescope.builtin').find_files()
end, { desc = 'Find files' })
```

### Autocommands
```lua
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'vim' },
  callback = function()
    vim.opt_local.shiftwidth = 2
  end,
})
```

### Option Setting
```lua
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt_global.spelllang = 'de_de'
```

## Plugin Ecosystem

### Core Dependencies
- **lazy.nvim**: Plugin manager
- **telescope.nvim**: Fuzzy finder
- **nvim-treesitter**: Syntax highlighting
- **mason.nvim**: LSP server management
- **which-key.nvim**: Key binding help

### Language Support
Currently configured for:
- **PHP**: phpactor LSP
- **TypeScript/JavaScript**: ts_ls LSP
- **Lua**: lua_ls LSP
- **HTML**: html LSP

### Adding New Plugins
1. Create new file in `lua/kickstart/plugins/` or add to `init.lua`
2. Follow the plugin configuration pattern above
3. Use lazy loading where possible
4. Include key mappings and descriptions

## Testing and Validation

### Configuration Validation
- Check syntax with Lua LSP
- Run `:checkhealth` for Neovim health
- Test key mappings with `:verbose map <leader>`

### Plugin Loading
- Use `:Lazy` to verify plugin status
- Check for conflicts in plugin specifications
- Ensure dependencies are properly declared

## German Localization

This configuration includes German language support:
- Spell checking: `vim.opt.spelllang = 'de_de'`
- Consider German-specific key mappings when adding new ones

## Customization Guidelines

### User Customizations
- Add custom plugins to `lua/custom/plugins/init.lua`
- Override core configurations in `lua/custom/` directory
- Maintain separation between core and custom configurations

### Performance Considerations
- Use lazy loading for heavy plugins
- Minimize startup time with appropriate `event` triggers
- Prefer `keys` over `cmd` for lazy loading when possible

## Common Tasks

### Adding Language Support
1. Install LSP server via Mason (`:Mason`)
2. Configure LSP in plugin spec
3. Add relevant treesitter parsers
4. Set up file type-specific autocommands

### Debugging Configuration
- Use `:lua print(vim.inspect(variable))` for debugging
- Check `:messages` for error output
- Use `:verbose` command to see where mappings/options were set

### Migration Notes
- When updating plugins, check breaking changes in plugin docs
- Test configuration after major Neovim updates
- Keep `lazy-lock.json` for reproducible setups

## Security Considerations

- Never commit sensitive data (API keys, passwords)
- Use environment variables for configuration secrets
- Validate external plugin sources before adding
- Review plugin code for security implications