#!/bin/bash
set -e

PKGS=(
	1password
)

yay -S --noconfirm --needed "${PKGS[@]}"
