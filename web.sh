#!/bin/bash
set -e

echo "Setup web packages"

PKGS=(
	chromium
	firefox
)

yay -S --noconfirm --needed "${PKGS[@]}"

echo "Web setup done"
