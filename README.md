# Dotfiles — Hyprland + Waybar + Rofi + more

A curated collection of configuration files for a custom Linux desktop
based on **Hyprland** (Wayland compositor), **Waybar** (status bar),
**Rofi** (launcher), and a full suite of quality-of-life tools.

## Components

| Directory | Tool | What's here |
|---|---|---|
| `hypr/` | Hyprland | Compositor config, binds, decorations, lock screen, idle |
| `waybar/` | Waybar | Bar config, style, Cava integration, control scripts |
| `rofi/` | Rofi | Launcher config, power menu, wallpaper switcher |
| `kitty/` | Kitty | Terminal config + themes |
| `fish/` | Fish shell | Config, functions, completions, conf.d drop-ins |
| `starship.toml` | Starship | Cross-shell prompt config |
| `swaync/` | Sway Notification Center | Notification UI + style |
| `cava/` | Cava | Audio visualizer config (feeds Waybar) |
| `btop/` | Btop | Resource monitor config + themes |
| `fastfetch/` | Fastfetch | System info output + ASCII logos |
| `colorscheme/` | — | Amanojaku color palette (CSS/JSON/Lua/TOML) |
| `matugen/` | Matugen | Material You color generator config |
| `rmpc/` | rmpc | Music player client config + retro-cyber theme |
| `wallpapers/` | — | Curated wallpaper collection |
| `cmus/lib.pl` | CMUS | Music player Lisp config |

## Quick start

```bash
# Clone
git clone --recursive https://github.com/Safaizal/dotfiles.git
cd dotfiles

# Symlink what you want
ln -sf ~/dotfiles/hypr ~/.config/hypr
ln -sf ~/dotfiles/waybar ~/.config/waybar
ln -sf ~/dotfiles/rofi ~/.config/rofi
# ... repeat for each tool you want
```

## Gallery

Hyprland + Waybar + Kitty + Rofi, Amanojaku color scheme, Cava audio
visualizer on the bar, rmpc with retro-cyber theme.

## Dependencies

```
hyprland  waybar  rofi-wayland  fish  starship  kitty
swaync  cava  btop  fastfetch  matugen  rmpc
```

## License

Feel free to use and modify.
