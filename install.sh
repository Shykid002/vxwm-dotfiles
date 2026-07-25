#!/usr/bin/env bash

# ==============================================================================
# VXWM Dotfiles Installer
# ==============================================================================
#
# Author : shykid002
# GitHub : https://github.com/Shylid002/vxwm-dotfiles
# License: MIT
# Version: 1.0.0
#
# ==============================================================================

# Catch error and Exit immediately
set -Eeuo pipefail

# ==========================
# Terminal Colors
# ==========================

BOLD="\e[1m"

BLUE="\e[34m"
CYAN="\e[36m"
GREEN="\e[32m"
PURPLE="\e[35m"
RED="\e[31m"
YELLOW="\e[33m"

RESET="\e[0m"


# Error handling function to show the failure dialog
failure_handler() {
    local exit_code=$?


    echo
    echo -e "${RED}=================================================${RESET}"
    echo -e "${BOLD}${RED}[ERROR] Installation Failed!${RESET}"
    echo
    echo -e "${YELLOW}Command:${RESET} ${BASH_COMMAND}"
    echo -e "${YELLOW}Line:${RESET} ${BASH_LINENO[0]}"
    echo -e "${YELLOW}Exit Code:${RESET} ${exit_code}"
    echo
    echo -e "${CYAN}If this is a bug, please open an issue on GitHub.${RESET}"
    echo -e "${RED}=================================================${RESET}"
}

# Trap any error and execute the failure handler
trap 'failure_handler' ERR


# Clear screen for a neat welcome interface
clear

# ==========================
# Welcome Banner
# ==========================

echo -e "${PURPLE}"

cat << "EOF"
                                 
__   ____  ____      ___ __ ___  
\ \ / /\ \/ /\ \ /\ / / '_ ` _ \ 
 \ V /  >  <  \ V  V /| | | | | |
  \_/  /_/\_\  \_/\_/ |_| |_| |_|
                                 
EOF

echo -e "${RESET}"

echo -e "${BOLD}${CYAN}Welcome to VXWM Dotfiles Installer${RESET}"
echo -e "${YELLOW}This installer will setup VXWM, dependencies, themes, and dotfiles.${RESET}"
echo
echo "--------------------------------------------------------"
echo

# ==========================
# Sudo Authentication
# ==========================

echo -e "${BLUE}[INFO]${RESET} Administrator privileges are required."

if ! sudo -v; then
    echo -e "${RED}[ERROR]${RESET} Failed to obtain sudo privileges."
    exit 1
fi


# ==========================
# Package Installation
# ==========================

PACMAN_PKGS="pkgs/pacman_pkgs.txt"

echo -e "${BLUE}[INFO]${RESET} Installing official packages..."

sudo pacman -S --needed --noconfirm \
    $(grep -vE '^\s*#|^\s*$' "$PACMAN_PKGS")

echo
echo -e "${GREEN}[OK]${RESET} Official packages installed successfully."
echo


# ==========================
# Install paru
# ==========================

# Ensure Rust is available
if ! command -v cargo >/dev/null 2>&1; then
    echo -e "${BLUE}[INFO]${RESET} Installing Rust..."

    sudo pacman -S --needed --noconfirm rust
fi

USER_NAME="${SUDO_USER:-$USER}"

if command -v paru >/dev/null 2>&1; then
    echo -e "${GREEN}[OK]${RESET} paru is already installed."
else
    echo -e "${BLUE}[INFO]${RESET} Installing paru..."

    PARU_DIR="/tmp/paru"

    rm -rf "$PARU_DIR"

    git clone https://aur.archlinux.org/paru.git "$PARU_DIR"

    chown -R "$USER_NAME:$USER_NAME" "$PARU_DIR"

    pushd "$PARU_DIR" >/dev/null

    sudo -u "$USER_NAME" makepkg -si --noconfirm

    popd >/dev/null

    rm -rf "$PARU_DIR"

    echo -e "${GREEN}[OK]${RESET} paru installed successfully."
fi

# ==========================
# Install AUR Packages
# ==========================

PARU_PKGS="pkgs/paru_pkgs.txt"

if [[ ! -f "$PARU_PKGS" ]]; then
    echo -e "${RED}[ERROR]${RESET} Missing package list: $PARU_PKGS"
    exit 1
fi

echo -e "${BLUE}[INFO]${RESET} Installing AUR packages..."

sudo -u "$USER_NAME" paru -S --needed --noconfirm \
    $(grep -vE '^\s*#|^\s*$' "$PARU_PKGS")

echo
echo -e "${GREEN}[OK]${RESET} AUR packages installed successfully."
echo

# ==========================
# Build and Install VXWM
# ==========================

VXWM_DIR="vxwm"

echo -e "${BLUE}[INFO]${RESET} Building and installing VXWM..."

# Verify the source directory exists
if [[ ! -d "$VXWM_DIR" ]]; then
    echo -e "${RED}[ERROR]${RESET} VXWM source directory not found: '$VXWM_DIR'"
    exit 1
fi

# Verify the Makefile exists
if [[ ! -f "$VXWM_DIR/Makefile" ]]; then
    echo -e "${RED}[ERROR]${RESET} Makefile not found in '$VXWM_DIR'"
    exit 1
fi

# Enter the source directory
pushd "$VXWM_DIR" >/dev/null

echo -e "${CYAN}[INFO]${RESET} Compiling VXWM..."
sudo make clean install

# Return to the previous directory
popd >/dev/null

echo -e "${GREEN}[OK]${RESET} VXWM installed successfully."
echo

# ==========================
# Build and Install vcompmgr
# ==========================

VCOMPMGR_DIR="vcompmgr"

echo -e "${BLUE}[INFO]${RESET} Building and installing vcompmgr..."

if [[ ! -d "$VCOMPMGR_DIR" ]]; then
    echo -e "${RED}[ERROR]${RESET} vcompmgr source directory not found: '$VCOMPMGR_DIR'"
    exit 1
fi

if [[ ! -f "$VCOMPMGR_DIR/Makefile" ]]; then
    echo -e "${RED}[ERROR]${RESET} Makefile not found in '$VCOMPMGR_DIR'"
    exit 1
fi

pushd "$VCOMPMGR_DIR" >/dev/null

echo -e "${CYAN}[INFO]${RESET} Compiling vcompmgr..."
sudo make clean install

popd >/dev/null

echo -e "${GREEN}[OK]${RESET} vcompmgr installed successfully."
echo

# ==========================
# Create XSession Entry
# ==========================

XSESSION_DIR="/usr/share/xsessions"
XSESSION_FILE="$XSESSION_DIR/vxwm.desktop"

echo -e "${BLUE}[INFO]${RESET} Creating XSession entry..."

sudo mkdir -p "$XSESSION_DIR"

sudo tee "$XSESSION_FILE" >/dev/null <<EOF
[Desktop Entry]
Name=VXWM
Comment=VXWM Window Manager
Exec=vxwm
Type=Application
DesktopNames=VXWM
EOF

echo -e "${GREEN}[OK]${RESET} XSession entry created."
echo

# ==========================
# Create Required Directories
# ==========================

DIRECTORIES=(

    "$HOME/.config"
    "$HOME/.config/dunst"
    "$HOME/.config/gtk-3.0"
    "$HOME/.config/gtk-4.0"
    "$HOME/.cache"

    "$HOME/Pictures/Screenshots"
    "$HOME/Pictures/Wallpapers"

)

echo -e "${BLUE}[INFO]${RESET} Creating required directories..."

mkdir -p "${DIRECTORIES[@]}"

echo -e "${GREEN}[OK]${RESET} Created ${#DIRECTORIES[@]} directories."
echo


# ==========================
# Install Xorg Configuration
# ==========================

echo -e "${BLUE}[INFO]${RESET} Installing Xorg configuration..."

sudo mkdir -p /etc/X11/xorg.conf.d

sudo install -Dm644 \
    "xorg-touch-pad/40-libinput.conf" \
    "/etc/X11/xorg.conf.d/40-libinput.conf"

echo -e "${GREEN}[OK]${RESET} Xorg configuration installed."
echo

# ==========================
# Theme Configuration
# ==========================

GTK_THEME="adw-gtk3-dark"
ICON_THEME="gruvbox-plus-icon-theme"
CURSOR_THEME="Bibata-Modern-Ice"


# ==========================
# Configure GTK Theme
# ==========================

echo -e "${BLUE}[INFO]${RESET} Applying GTK theme..."

# GTK2
cat > "$HOME/.gtkrc-2.0" << EOF
gtk-theme-name="${GTK_THEME}"
gtk-icon-theme-name="${ICON_THEME}"
gtk-cursor-theme-name="${CURSOR_THEME}"
EOF

# GTK3
cat > "$HOME/.config/gtk-3.0/settings.ini" << EOF
[Settings]
gtk-theme-name=${GTK_THEME}
gtk-icon-theme-name=${ICON_THEME}
gtk-cursor-theme-name=${CURSOR_THEME}
gtk-application-prefer-dark-theme=1
EOF

# GTK4
cat > "$HOME/.config/gtk-4.0/settings.ini" << EOF
[Settings]
gtk-theme-name=${GTK_THEME}
gtk-icon-theme-name=${ICON_THEME}
gtk-cursor-theme-name=${CURSOR_THEME}
gtk-application-prefer-dark-theme=1
EOF

echo -e "${GREEN}[OK]${RESET} GTK theme configured successfully."
echo

# ==========================
# Install Utility Scripts
# ==========================
SCRIPTS_DIR="scripts"
USER_SCRIPTS_DIR="$HOME/scripts"


SCRIPTS=(
    brightness.sh
    ss.sh
    rofi-wallpaper.sh
    volume.sh
    wal-dunst.sh
    vxwm_bar.sh
    kbdbrightness.sh
)

echo -e "${BLUE}[INFO]${RESET} Installing utility scripts..."

# Create destination directory
mkdir -p "$USER_SCRIPTS_DIR"

for script in "${SCRIPTS[@]}"; do

    SOURCE="$SCRIPTS_DIR/$script"
    DESTINATION="$USER_SCRIPTS_DIR/$script"

    if [[ -f "$SOURCE" ]]; then

        install -m755 "$SOURCE" "$DESTINATION"

        echo -e "${GREEN}[OK]${RESET} Installed $script"

    else

        echo -e "${YELLOW}[WARN]${RESET} Missing script: $SOURCE"

    fi

done

echo


# ==========================
# Install Home Dotfiles
# ==========================

HOME_FILES=(
    .xinitrc
    .xprofile
    .Xresources
    .bashrc
    .bash_profile
    .bash_history
)

echo -e "${BLUE}[INFO]${RESET} Installing home configuration files..."

for file in "${HOME_FILES[@]}"; do

    if [[ -f "$file" ]]; then

        install -m644 "$file" "$HOME/$file"

        echo -e "${GREEN}[OK]${RESET} Installed: $file"

    else

        echo -e "${YELLOW}[WARN]${RESET} Missing: $file"

    fi

done

echo -e "${GREEN}[OK]${RESET} Home configuration files installed."
echo


# ==========================
# Install Wallpapers
# ==========================

WALLPAPERS_DIR="wallpapers"
USER_WALLPAPER_DIR="$HOME/Pictures/Wallpapers"



echo -e "${BLUE}[INFO]${RESET} Installing wallpapers..."

# Create destination directory
mkdir -p "$USER_WALLPAPER_DIR"

if [[ -d "$WALLPAPERS_DIR" ]]; then

    find "$WALLPAPERS_DIR" -type f \
        \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) |
    while read -r wallpaper; do

        install -m644 "$wallpaper" "$USER_WALLPAPER_DIR/"

        echo -e "${GREEN}[OK]${RESET} Installed: $(basename "$wallpaper")"

    done

    echo -e "${GREEN}[OK]${RESET} Wallpapers installed."

else

    echo -e "${YELLOW}[WARN]${RESET} Wallpaper directory not found."

fi

echo

# ==========================
# Install Configuration Files
# ==========================

CONFIGS_DIR="configs"

echo -e "${BLUE}[INFO]${RESET} Installing configuration files..."

if [[ -d "$CONFIGS_DIR" ]]; then

    # Create ~/.config if it doesn't already exist
    mkdir -p "$HOME/.config"

    # Copy all configuration files and directories
    cp -a "$CONFIGS_DIR"/. "$HOME/.config/"

    echo -e "${GREEN}[OK]${RESET} Configuration files installed successfully."

else

    echo -e "${YELLOW}[WARN]${RESET} Configuration directory not found: '$CONFIGS_DIR'"

fi

echo

# ==========================
# Install Cache Files
# ==========================

CACHE_DIR="cache"

echo -e "${BLUE}[INFO]${RESET} Installing cache files..."

if [[ -d "$CACHE_DIR" ]]; then

    # Create ~/.cache if it doesn't exist
    mkdir -p "$HOME/.cache"

    # Copy all cache files
    cp -a "$CACHE_DIR"/. "$HOME/.cache/"

    echo -e "${GREEN}[OK]${RESET} Cache files installed successfully."

else

    echo -e "${YELLOW}[WARN]${RESET} Cache directory not found: '$CACHE_DIR'"

fi

echo

# ==========================
# Enable System Services
# ==========================

SERVICES=(
    tlp.service
    mbpfan.service
)

echo -e "${BLUE}[INFO]${RESET} Enabling and starting system services..."

for service in "${SERVICES[@]}"; do

    if systemctl list-unit-files --type=service | grep -q "^${service}"; then

        if systemctl is-enabled "$service" &>/dev/null; then
            echo -e "${GREEN}[OK]${RESET} Already enabled: $service"
        else
            sudo systemctl enable "$service"
            echo -e "${GREEN}[OK]${RESET} Enabled and started: $service"
        fi

    else

        echo -e "${YELLOW}[WARN]${RESET} Service not found: $service"

    fi

done

echo


# ==========================
# Configure Ly Display Manager
# ==========================

echo -e "${BLUE}[INFO]${RESET} Configuring Ly display manager..."

# Disable the default getty on tty2
sudo systemctl disable getty@tty2.service

# Enable and start Ly on tty2
sudo systemctl enable --now ly@tty2.service

echo -e "${GREEN}[OK]${RESET} Ly has been configured successfully."
echo

# ==========================
# Installation Complete
# ==========================

echo
echo -e "${GREEN}${BOLD}========================================${RESET}"
echo -e "${GREEN}${BOLD}      Installation Complete!${RESET}"
echo -e "${GREEN}${BOLD}========================================${RESET}"
echo
echo -e "${GREEN}✓${RESET} Dependencies installed"
echo -e "${GREEN}✓${RESET} paru installed"
echo -e "${GREEN}✓${RESET} adw-gtk-theme installed"
echo -e "${GREEN}✓${RESET} VXWM compiled"
echo -e "${GREEN}✓${RESET} Wallpapers installed"
echo -e "${GREEN}✓${RESET} Utility scripts installed"
echo -e "${GREEN}✓${RESET} Configuration files installed"
echo -e "${GREEN}✓${RESET} Cache files installed"
echo
echo -e "${CYAN}${BOLD}Launch VXWM:${RESET}"
echo -e "  ${YELLOW}startx${RESET}"
echo
echo -e "${PURPLE}Thank you for using VXWM Dotfiles!${RESET}"
echo -e "${BLUE}Enjoy your new setup!${RESET}"
echo
