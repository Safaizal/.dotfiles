# Dotfiles Configuration

A collection of configuration files for a customized Linux desktop environment, featuring Hyprland as the main Wayland compositor.

## 📋 Overview

This repository contains dotfiles for various applications and tools:

| Component | Description |
|-----------|-------------|
| **Hyprland** | Dynamic tiling Wayland compositor with Lua configuration |
| **Waybar** | Highly customizable Wayland status bar |
| **Rofi** | Application launcher and window switcher |
| **Fish** | Friendly interactive shell configuration |
| **Starship** | Cross-shell prompt with custom theme |
| **Kitty** | GPU-accelerated terminal emulator |
| **Cava** | Console-based audio visualizer |
| **Btop** | Modern resource monitor |
| **Fastfetch** | System information tool |
| **Matugen** | Material You color scheme generator |
| **GTK/Qt** | Theme configurations for GTK3, GTK4, Qt5, and Qt6 |
| **MPV/MPD** | Media player configurations |
| **Yazi** | Terminal file manager |
| **Nvim** | Neovim configuration (submodule) |

## 🚀 Installation

### Prerequisites

- A Linux distribution with Wayland support
- Git

### Clone the Repository

```bash
git clone --recursive https://github.com/Safaizal/dotfiles.git ~/.config
```

> **Note:** The `--recursive` flag is important to include the Neovim submodule.

### Manual Installation (Symlink Method)

```bash
# Example for Hyprland
ln -sf ~/.config/hypr/hyprland.conf ~/.config/hypr/hyprland.conf
ln -sf ~/.config/hypr/hyprlock.conf ~/.config/hypr/hyprlock.conf

# Example for Waybar
ln -sf ~/.config/waybar/config.jsonc ~/.config/waybar/config.jsonc
ln -sf ~/.config/waybar/style.css ~/.config/waybar/style.css

# Example for Fish
ln -sf ~/.config/fish/config.fish ~/.config/fish/config.fish

# Example for Starship
ln -sf ~/.config/starship.toml ~/.config/starship.toml
```

## 📁 Directory Structure

```
.
├── hypr/           # Hyprland compositor configs (hyprland.lua, hyprlock.conf)
├── waybar/         # Waybar status bar (config, styles, scripts)
├── rofi/           # Rofi launcher themes and config
├── fish/           # Fish shell configuration
├── kitty/          # Kitty terminal emulator config
├── starship.toml   # Starship prompt configuration
├── btop/           # Btop resource monitor theme
├── cava/           # Cava audio visualizer config
├── fastfetch/      # Fastfetch system info config
├── matugen/        # Matugen color scheme config
├── mpv/            # MPV media player config
├── mpd/            # MPD music player daemon config
├── ncspot/         # Ncspot Spotify client config
├── rmpc/           # RMPD client config
├── yazi/           # Yazi file manager config
├── gtk-3.0/        # GTK3 theme settings
├── gtk-4.0/        # GTK4 theme settings
├── qt5ct/          # Qt5 configuration
├── qt6ct/          # Qt6 configuration
├── nwg-look/       # GTK look settings
├── xsettingsd/     # X settings daemon config
├── autostart/      # Autostart entries
├── colorscheme/    # Color scheme definitions
├── Kvantum/        # Kvantum theme engine config
├── swaync/         # Sway notification center config
└── wallpapers/     # Wallpaper images
```

## ⚙️ Key Components

### Hyprland
The main window manager configuration uses Lua for better modularity:
- `hyprland.lua` - Main Hyprland configuration
- `hyprlock.conf` - Lock screen configuration
- `hypridle.conf` - Idle management
- `modules/` - Additional configuration modules

### Waybar
Customizable status bar with:
- Custom JSONC configuration
- CSS styling
- Shell scripts for custom modules
- Multiple themes support

### Rofi
Application launcher with:
- Custom Rasi configuration
- Theme support
- Custom scripts for extended functionality

### Fish Shell
Interactive shell with auto-suggestions and syntax highlighting.

### Starship
Custom prompt theme with:
- OS icons
- Directory path
- Git branch and status
- Language runtime versions (Node.js, Bun, Rust, Go, PHP, Python)
- Time display

## 🎨 Themes & Colors

This setup uses **Matugen** for generating Material You color schemes based on wallpapers. Color configurations are stored in:
- `colorscheme/` - Base color definitions
- `matugen/` - Matugen configuration templates

## 🔧 Dependencies

Main packages required (package names may vary by distribution):

```bash
# Core
hyprland
waybar
rofi-wayland
fish
starship

# Terminal & Display
kitty
hyprlock
hypridle

# System Tools
btop
fastfetch
cava

# Theming
matugen
nwg-look
kvantum
qt5ct
qt6ct

# Media
mpv
mpd
ncspot

# File Management
yazi

# Notifications
swaynotificationcenter
```

## 📝 Notes

- **Neovim**: Configured as a git submodule pointing to [Safaizal/nvim](https://github.com/Safaizal/nvim.git)
- **Runtime Files**: Some directories exclude runtime/state files via `.gitignore`:
  - `cmus/` - Excludes cache, playlists, and state files
  - `mpd/` - Excludes database, logs, and state files

## 📄 License

Feel free to use and modify these configurations as needed.

## 🙏 Credits

- Inspired by various dotfile repositories in the community
- Built with love for a productive and beautiful desktop experience

---

**Last Updated**: 2024
