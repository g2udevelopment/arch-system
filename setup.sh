#!/bin/bash
set -e

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$BASE_DIR/config"
SCRIPT_DIR="$BASE_DIR/scripts"

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
    wofi
    thunar
    grim
    slurp
    wl-clipboard
    ttf-jetbrains-mono-nerd
    nvim
    networkmanager
    mesa
    intel-media-driver
    vulkan-intel
    #vulkan-radeon
    bluez
    bluez-utils
    pipewire
    pipewire-alsa
    pipewire-pulse
    wireplumber
    pipewire-audio
    pamixer
)

yay -S --noconfirm --needed "${PKGS[@]}"

echo "Package install done, linking configs"

mkdir -p ~/.config/{hypr,waybar,mako,foot,gtk-3.0}

[ -f "$CONFIG_DIR/hypr/hyprland.conf" ] && ln -sf "$CONFIG_DIR/hypr/hyprland.conf" ~/.config/hypr/hyprland.conf
[ -f "$CONFIG_DIR/waybar/config" ] && ln -sf "$CONFIG_DIR/waybar/config" ~/.config/waybar/config
[ -f "$CONFIG_DIR/waybar/style.css" ] && ln -sf "$CONFIG_DIR/waybar/style.css" ~/.config/waybar/style.css
[ -f "$CONFIG_DIR/mako/config" ] && ln -sf "$CONFIG_DIR/mako/config" ~/.config/mako/config
[ -f "$CONFIG_DIR/foot/foot.ini" ] && ln -sf "$CONFIG_DIR/foot/foot.ini" ~/.config/foot/foot.ini
[ -f "$CONFIG_DIR/gtk-3.0/settings.ini" ] && ln -sf "$CONFIG_DIR/gtk-3.0/settings.ini" ~/.config/gtk-3.0/settings.ini
echo "Linking scripts"

mkdir -p ~/.local/bin

[ -f "$SCRIPT_DIR/wofi-launch.sh" ] && ln -sf "$SCRIPT_DIR/wofi-launch.sh" ~/.local/bin/wofi-launch.sh

echo "Startup Hyprland from tty"

if [ ! -f ~/.bash_profile ] || ! grep -q "Hyprland" ~/.bash_profile; then
    echo '[ "$(tty)" = "/dev/tty1" ] && exec Hyprland' >> ~/.bash_profile
fi

