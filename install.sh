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
    matugen-bin
    rmpc
    ncspot
    zscroll-git
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
# 4. Clone Repository & Symlink
# ==========================================

if [ -d "$TARGET_DIR" ]; then
    echo "==> Dotfiles directory already exists at $TARGET_DIR. Pulling latest changes..."
    cd "$TARGET_DIR"
    git pull origin main
else
    echo "==> Cloning dotfiles repository..."
    git clone "$REPO_URL" "$TARGET_DIR"
    cd "$TARGET_DIR"
fi

# Ensure .config exists
mkdir -p "$CONFIG_DIR"

echo "==> Symlinking configurations..."
# This assumes your repo has a folder named 'config' or you want to link the contents directly.
# If the root of your git repo directly contains the folders (like hypr, waybar, kitty), use:
for d in */; do
    # Skip any .git directory
    if [[ "$d" == ".git/" ]]; then continue; fi
    
    folder_name="${d%/}"
    echo " -> Linking $folder_name to $CONFIG_DIR/$folder_name"
    
    # Remove existing conflicting directories/files before symlinking
    if [ -e "$CONFIG_DIR/$folder_name" ]; then
        echo "    Backing up existing $CONFIG_DIR/$folder_name to $CONFIG_DIR/$folder_name.bak"
        mv "$CONFIG_DIR/$folder_name" "$CONFIG_DIR/$folder_name.bak"
    fi
    
    ln -sf "$TARGET_DIR/$folder_name" "$CONFIG_DIR/$folder_name"
done

echo "============================================="
echo " Installation Complete! Restart your session."
echo "============================================="
