# Neovim Setup for Rust Development (Windows)

This README covers everything needed to install and run this Neovim configuration on Windows, from a fresh machine to a working Rust development environment.

## 1. Prerequisites

Install these before touching the Neovim config. All commands are run in PowerShell.

### Git
Required by `lazy.nvim` (the plugin manager) to clone plugins.
```powershell
winget install Git.Git
```

### Rust toolchain (rustup)
Gives you `cargo`, `rustfmt`, and the Rust compiler.
```powershell
winget install Rustlang.Rustup
rustup component add rust-analyzer rustfmt
```

### Zig
Acts as a C compiler so `nvim-treesitter` can compile syntax parsers on Windows without needing full Visual Studio Build Tools.
```powershell
winget install zig.zig
```

### ripgrep
Used by Telescope for fast fuzzy/live-grep searching.
```powershell
winget install BurntSushi.ripgrep.MSVC
```

### A Nerd Font
Provides the icons used by the file explorer, statusline, and diagnostics. Without this, icons render as boxes/question marks.

1. Download a font from [nerdfonts.com](https://www.nerdfonts.com/) — e.g. **JetBrainsMono Nerd Font**.
2. Install it (double-click the `.ttf`/`.otf` file → Install).
3. Set it as the font in your terminal app (Windows Terminal, etc.) under Settings → Profile → Appearance → Font face.

## 2. Neovim itself

If not already installed:
```powershell
winget install Neovim.Neovim
```

To update later:
```powershell
winget upgrade Neovim.Neovim
```

## 3. Config location

Neovim reads its config from:
```
%LOCALAPPDATA%\nvim\init.lua
```
Which expands to:
```
C:\Users\<you>\AppData\Local\nvim\init.lua
```

Plugin-specific data (installed plugins, parsers, undo history) lives separately in:
```
C:\Users\<you>\AppData\Local\nvim-data\
```

## 4. Plugin manager (lazy.nvim)

The config bootstraps `lazy.nvim` automatically on first launch — it clones itself into `nvim-data\lazy\lazy.nvim` the first time you open Neovim. No manual step needed here, just make sure Git (above) is installed first.

## 5. First launch checklist

1. Open a terminal with your Nerd Font set.
2. Run `nvim`. On first launch, `lazy.nvim` will clone itself, then install all configured plugins automatically.
3. Once it finishes, run `:Lazy sync` to make sure everything is up to date.
4. Run `:checkhealth` to confirm Neovim sees Git, a C compiler (Zig), and ripgrep correctly.
5. Run `:checkhealth nvim-treesitter` to confirm the Rust parser compiled successfully.
6. Run `:Mason` and confirm `rust-analyzer` is installed (it installs automatically via `mason-lspconfig`, but this lets you check).
7. Open a `.rs` file inside a real Cargo project (e.g. `cargo new test-project`) and confirm:
   - Syntax highlighting appears
   - Hovering a symbol (`K`) shows type info
   - Autocomplete triggers as you type
   - Saving the file runs `rustfmt` automatically

## 6. Known Windows-specific gotchas

- **`hererocks`/LuaRocks warning** — `lazy.nvim` tries to bootstrap a Lua 5.1 install for LuaRocks-based plugins by default. This setup doesn't need it and disables it via `rocks.enabled = false` in `init.lua`.
- **Treesitter parser "Access is denied" errors** — Windows can lock newly-written parser files, often due to Windows Defender scanning them mid-move. If you hit this: close all Neovim instances, add an exclusion for `nvim-data` in Windows Security (Virus & threat protection → Manage settings → Exclusions), then retry `:TSUpdate`.
- **Treesitter API changes** — `nvim-treesitter` has both a legacy (`master`) and rewritten (`main`) branch with different APIs. This config pins to `master` for stability; don't switch branches without also rewriting the treesitter config.

## 7. Updating everything later

| What | Command |
|---|---|
| Neovim itself | `winget upgrade Neovim.Neovim` |
| All plugins | `:Lazy sync` (inside Neovim) |
| Treesitter parsers | `:TSUpdate` |
| LSP servers / formatters (Mason) | `:Mason` → press `U` to update all |
| Rust toolchain | `rustup update` |

## 8. Directory structure reference

```
%LOCALAPPDATA%\nvim\
├── init.lua                  # entry point: options, leader key, lazy.nvim bootstrap
└── lua\
    └── plugins\
        ├── colorscheme.lua   # rose-pine
        ├── treesitter.lua    # syntax highlighting
        ├── lsp.lua           # mason + lspconfig
        ├── rust.lua          # rustaceanvim (rust-analyzer config)
        ├── completion.lua    # nvim-cmp
        ├── format.lua        # conform.nvim (rustfmt on save)
        ├── telescope.lua     # fuzzy finder
        └── explorer.lua      # nvim-tree file browser
```
