#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$SCRIPT_DIR/config"

sudo pacman -Syu --noconfirm --needed base-devel git

if ! command -v yay &>/dev/null; then
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
fi

PKGS=(
    hyprland
    xdg-desktop-portal-hyprland
    qt5-wayland
    qt6-wayland
    waybar
    mako
    foot
    thunar
    grim
    slurp
    wl-clipboard
    ttf-jetbrains-mono-nerd
    nvim
    networkmanager
)

yay -S --noconfirm --needed "${PKGS[@]}"

echo "Package install done, linking configs"

mkdir -p ~/.config/{hypr,waybar,mako,foot}

[ -f "$CONFIG_DIR/hypr/hyprland.conf" ] && ln -sf "$CONFIG_DIR/hypr/hyprland.conf" ~/.config/hypr/hyprland.conf
[ -f "$CONFIG_DIR/waybar/config" ] && ln -sf "$CONFIG_DIR/waybar/config" ~/.config/waybar/config
[ -f "$CONFIG_DIR/waybar/style.css" ] && ln -sf "$CONFIG_DIR/waybar/style.css" ~/.config/waybar/style.css
[ -f "$CONFIG_DIR/mako/config" ] && ln -sf "$CONFIG_DIR/mako/config" ~/.config/mako/config
[ -f "$CONFIG_DIR/foot/foot.ini" ] && ln -sf "$CONFIG_DIR/foot/foot.ini" ~/.config/foot/foot.ini

