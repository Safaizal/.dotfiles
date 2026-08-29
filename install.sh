#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

REPO_URL="https://github.com/Safaizal/.dotfiles.git"
TARGET_DIR="$HOME/.dotfiles"
CONFIG_DIR="$HOME/.config"

echo "============================================="
echo "   Automated Dotfiles & Dependency Installer "
echo "============================================="

# ==========================================
# 1. Define Dependencies
# ==========================================

# Core system, window manager, and utilities (pacman)
PACMAN_PKGS=(
    git
    stow # Used for symlinking dotfiles cleanly
    base-devel

    # Hyprland & Wayland Ecosystem
    hyprland
    waybar
    swaync
    rofi-wayland
    polkit-kde-agent
    xdg-utils
    wl-clipboard
    grim
    slurp
    power-profiles-daemon

    # For fastfetch image processing
    imagemagick
    chafa

    # Terminal, Shell & Editors
    kitty
    fish
    starship
    fastfetch
    btop
    htop
    yazi
    neovim

    # Media & Theming
    cava
    mpd
    mpv
    cmus
    pavucontrol
    gtk3
    gtk4
    kvantum
    qt5ct
    qt6ct
    xsettingsd
    nwg-look
)

# AUR Packages
AUR_PKGS=(
    matugen
    rmpc
    ncspot
    zscroll
)

# ==========================================
# 2. System Update & Helper Installation
# ==========================================

echo "==> Updating system..."
sudo pacman -Syu --noconfirm

echo "==> Ensuring core packages are installed..."
sudo pacman -S --needed --noconfirm git base-devel stow

# Install AUR helper (yay) if not present
if ! command -v yay &> /dev/null && ! command -v paru &> /dev/null; then
    echo "==> AUR helper not found. Installing yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    (cd /tmp/yay && makepkg -si --noconfirm)
    rm -rf /tmp/yay
fi

AUR_HELPER=$(command -v paru || command -v yay)

# ==========================================
# 3. Install Dependencies
# ==========================================

echo "==> Installing official repository packages..."
sudo pacman -S --needed --noconfirm "${PACMAN_PKGS[@]}"

echo "==> Installing AUR packages..."
"$AUR_HELPER" -S --needed --noconfirm "${AUR_PKGS[@]}"

echo "==> Enabling background services..."
sudo systemctl enable --now power-profiles-daemon.service || true

# ==========================================
# 4. Clone Repository & Configure
# ==========================================

if [ -d "$TARGET_DIR" ]; then
    echo "==> Dotfiles directory already exists at $TARGET_DIR. Pulling latest changes..."
    cd "$TARGET_DIR"
    git pull origin main
    git submodule update --init --recursive
else
    echo "==> Cloning dotfiles repository..."
    git clone --recurse-submodules "$REPO_URL" "$TARGET_DIR"
    cd "$TARGET_DIR"
fi

# Ensure .config exists
mkdir -p "$CONFIG_DIR"

# Helper: deploy a file/dir into ~/.config, backing up any conflicting copy
deploy () {
    local src="$1"
    local dst="$CONFIG_DIR/$(basename "$src")"

    if [ -e "$dst" ]; then
        local backup="$dst.bak.$(date +%Y%m%d-%H%M%S)"
        echo "    Backing up existing $dst to $backup"
        mv "$dst" "$backup"
    fi

    cp -r "$src" "$dst"

    # Don't leave a nested git repository behind (e.g. the nvim submodule)
    rm -rf "$dst/.git"
}

# Only deploy directories that contain tracked files (skips e.g. empty cmus)
has_tracked_files () {
    [ -n "$(git ls-files "$1" | head -n1)" ]
}

echo "==> Copying configurations..."

for d in */; do
    # Skip any .git directory
    if [[ "$d" == ".git/" ]]; then continue; fi

    folder_name="${d%/}"

    # Skip directories that carry no tracked configuration
    if ! has_tracked_files "$folder_name"; then
        echo " -> Skipping $folder_name (no tracked files)"
        continue
    fi

    echo " -> Copying $folder_name to $CONFIG_DIR/$folder_name"
    deploy "$TARGET_DIR/$folder_name"
done

# Deploy top-level dotfiles (the loop above only handles directories)
if [ -f "$TARGET_DIR/starship.toml" ]; then
    echo " -> Copying starship.toml to $CONFIG_DIR/starship.toml"
    deploy "$TARGET_DIR/starship.toml"
fi

echo "============================================="
echo " Installation Complete! Restart your session."
echo "============================================="