#!/bin/bash
# dotfiles install script
# Usage: ./install.sh

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==============================="
echo "  Dotfiles Installer"
echo "==============================="
echo ""
echo "Which machine is this?"
echo "  1) ThinkPad (Arch Linux)"
echo "  2) Zorin OS (School Desktop)"
echo ""
read -p "Select [1/2]: " MACHINE

case "$MACHINE" in
    1) PROFILE="thinkpad" ;;
    2) PROFILE="zorin" ;;
    *) echo "Invalid selection"; exit 1 ;;
esac

echo ""
echo "Setting up: $PROFILE"
echo ""

# ============================================================
# Install packages
# ============================================================
install_packages() {
    if [ "$PROFILE" = "thinkpad" ]; then
        echo "[*] Installing packages (pacman)..."
        sudo pacman -S --needed --noconfirm \
            i3-wm polybar kitty rofi thunar feh picom \
            maim xdotool xclip playerctl pamixer pavucontrol \
            i3lock dex xss-lock network-manager-applet \
            ttf-jetbrains-mono-nerd otf-font-awesome \
            papirus-icon-theme breeze-gtk
    elif [ "$PROFILE" = "zorin" ]; then
        echo "[*] Installing packages (apt)..."
        sudo apt update
        sudo apt install -y \
            i3 polybar kitty rofi thunar feh picom \
            maim xdotool xclip playerctl pamixer pavucontrol \
            i3lock dex xss-lock network-manager-gnome \
            fonts-jetbrains-mono papirus-icon-theme \
            breeze-gtk-theme lxappearance
    fi
}

read -p "Install packages? [y/N]: " INSTALL_PKGS
if [ "$INSTALL_PKGS" = "y" ] || [ "$INSTALL_PKGS" = "Y" ]; then
    install_packages
fi

# ============================================================
# Create directories
# ============================================================
echo "[*] Creating config directories..."
mkdir -p ~/.config/i3
mkdir -p ~/.config/polybar
mkdir -p ~/.config/kitty/kitty-themes
mkdir -p ~/.config/rofi
mkdir -p ~/.config/gtk-3.0
mkdir -p ~/Pictures/Screenshots

# ============================================================
# Backup existing configs
# ============================================================
backup_if_exists() {
    if [ -e "$1" ] && [ ! -L "$1" ]; then
        echo "  Backing up $1 -> $1.bak"
        mv "$1" "$1.bak"
    elif [ -L "$1" ]; then
        rm "$1"
    fi
}

echo "[*] Backing up existing configs..."
backup_if_exists ~/.config/i3/config
backup_if_exists ~/.config/i3/powermenu.sh
backup_if_exists ~/.config/polybar/config.ini
backup_if_exists ~/.config/polybar/launch.sh
backup_if_exists ~/.config/kitty/kitty.conf
backup_if_exists ~/.config/kitty/kitty-themes/Hipster_Green.conf
backup_if_exists ~/.config/rofi/config.rasi
backup_if_exists ~/.config/gtk-3.0/settings.ini

# ============================================================
# Symlink shared configs
# ============================================================
echo "[*] Linking shared configs..."
ln -sf "$DOTFILES_DIR/shared/kitty/kitty.conf" ~/.config/kitty/kitty.conf
ln -sf "$DOTFILES_DIR/shared/kitty/kitty-themes/Hipster_Green.conf" ~/.config/kitty/kitty-themes/Hipster_Green.conf
ln -sf "$DOTFILES_DIR/shared/rofi/config.rasi" ~/.config/rofi/config.rasi
ln -sf "$DOTFILES_DIR/shared/gtk-3.0/settings.ini" ~/.config/gtk-3.0/settings.ini
ln -sf "$DOTFILES_DIR/shared/polybar-launch.sh" ~/.config/polybar/launch.sh
chmod +x ~/.config/polybar/launch.sh

# ============================================================
# Symlink machine-specific configs
# ============================================================
echo "[*] Linking $PROFILE configs..."
ln -sf "$DOTFILES_DIR/$PROFILE/i3/config" ~/.config/i3/config
ln -sf "$DOTFILES_DIR/$PROFILE/i3/powermenu.sh" ~/.config/i3/powermenu.sh
ln -sf "$DOTFILES_DIR/$PROFILE/polybar/config.ini" ~/.config/polybar/config.ini
chmod +x ~/.config/i3/powermenu.sh

# ============================================================
# Post-install reminders
# ============================================================
echo ""
echo "==============================="
echo "  Setup complete!"
echo "==============================="
echo ""

if [ "$PROFILE" = "zorin" ]; then
    echo "BEFORE LOGGING INTO i3, you need to update two values:"
    echo ""
    echo "  1. Monitor output name:"
    echo "     Run: xrandr --query | grep ' connected'"
    echo "     Edit: ~/.config/i3/config"
    echo "     Replace CHANGEME in the xrandr line with your output name"
    echo ""
    echo "  2. Ethernet interface name:"
    echo "     Run: ip link"
    echo "     Edit: ~/.config/polybar/config.ini"
    echo "     Replace CHANGEME in [module/eth] with your interface name"
    echo ""
    echo "  3. (Optional) Check thermal zone:"
    echo "     Run: ls /sys/class/thermal/"
    echo "     Update thermal-zone in polybar config if needed"
    echo ""
    echo "  4. Place a wallpaper at: ~/Pictures/wallpaper.jpg"
    echo ""
    echo "Then log out, select i3 at the login screen, and log in."
elif [ "$PROFILE" = "thinkpad" ]; then
    echo "Configs linked. Restart i3 with \$mod+Shift+r"
fi
