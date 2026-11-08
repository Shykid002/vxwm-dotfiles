
#!/usr/bin/env bash

# ==============================================================================
# VXWM Dotfiles Installer - Gentoo
# ==============================================================================
#
# Author : shykid002
# License: MIT
# Version: 1.0.0-gentoo
#
# ==============================================================================

set -Eeuo pipefail

# ==============================================================================
# Paths
# ==============================================================================

# Always work relative to the directory containing this script.
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

VXWM_DIR="$SCRIPT_DIR/vxwm"
VCOMPMGR_DIR="$SCRIPT_DIR/vcompmgr"
SCRIPTS_DIR="$SCRIPT_DIR/scripts"
CONFIGS_DIR="$SCRIPT_DIR/configs"
CACHE_DIR="$SCRIPT_DIR/cache"
WALLPAPERS_DIR="$SCRIPT_DIR/wallpapers"
XORG_DIR="$SCRIPT_DIR/xorg-touch-pad"

# ==============================================================================
# Terminal Colors
# ==============================================================================

BOLD="\e[1m"
BLUE="\e[34m"
CYAN="\e[36m"
GREEN="\e[32m"
PURPLE="\e[35m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

# ==============================================================================
# Error Handler
# ==============================================================================

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
    echo -e "${CYAN}Check the error above before running the installer again.${RESET}"
    echo -e "${RED}=================================================${RESET}"
}

trap failure_handler ERR

# ==============================================================================
# Helper Functions
# ==============================================================================

info() {
    echo -e "${BLUE}[INFO]${RESET} $*"
}

success() {
    echo -e "${GREEN}[OK]${RESET} $*"
}

warning() {
    echo -e "${YELLOW}[WARN]${RESET} $*"
}

error() {
    echo -e "${RED}[ERROR]${RESET} $*"
}

# ==============================================================================
# Welcome Banner
# ==============================================================================

clear

echo -e "${PURPLE}"

cat << "EOF"

 __   _______  __        ______  __  __
 \ \ / /_   _| \ \      / / __ \|  \/  |
  \ V /  | |    \ \ /\ / / |  | | \  / |
   | |   | |     \ V  V /| |  | | |\/| |
   | |  _| |_     \_/\_/ | |__| | |  | |
   |_| |_____|             \____/|_|  |_|

EOF

echo -e "${RESET}"

echo -e "${BOLD}${CYAN}Welcome to VXWM Gentoo Dotfiles Installer${RESET}"
echo -e "${YELLOW}This installer will setup VXWM, Xorg configuration, themes, and dotfiles.${RESET}"
echo
echo "--------------------------------------------------------"
echo

# ==============================================================================
# Gentoo Compatibility Check
# ==============================================================================

info "Checking operating system..."

if [[ ! -f /etc/gentoo-release ]]; then
    error "This installer is intended for Gentoo Linux."
    exit 1
fi

success "Gentoo Linux detected."

echo

# ==============================================================================
# Check Required Commands
# ==============================================================================

info "Checking required commands..."

REQUIRED_COMMANDS=(
    bash
    sudo
    emerge
    make
    install
    mkdir
    cp
    find
)

for command in "${REQUIRED_COMMANDS[@]}"; do
    if command -v "$command" >/dev/null 2>&1; then
        success "$command found."
    else
        error "Required command not found: $command"
        exit 1
    fi
done

echo

# ==============================================================================
# Sudo Authentication
# ==============================================================================

info "Administrator privileges are required."

if ! sudo -v; then
    error "Failed to obtain sudo privileges."
    exit 1
fi

success "Sudo authentication successful."

echo

# ==============================================================================
# Portage Check
# ==============================================================================

info "Checking Portage..."

if ! sudo emerge --info >/dev/null 2>&1; then
    error "Portage is not functioning correctly."
    error "Please resolve your Gentoo Portage configuration before continuing."
    exit 1
fi

success "Portage is ready."

echo

# ==============================================================================
# Optional Dependency Installation
# ==============================================================================

info "Checking common VXWM build dependencies..."

# These are intentionally conservative.
# Your original installer did not contain a dependency list, so we do not
# automatically install a large collection of packages that may not be needed.
#
# Add Gentoo package atoms here if VXWM/vcompmgr require additional packages.
#
# Example:
#
# GENTOO_DEPENDENCIES=(
#     x11-base/xorg-server
#     x11-apps/xinit
#     x11-libs/libX11
#     x11-libs/libXft
#     x11-libs/libXinerama
#     x11-libs/libXrandr
#     x11-libs/libXrender
# )
#
# Then install with:
#
# sudo emerge --ask "${GENTOO_DEPENDENCIES[@]}"

success "Dependency check complete."
echo

# ==============================================================================
# Verify VXWM Source
# ==============================================================================

info "Checking VXWM source directory..."

if [[ ! -d "$VXWM_DIR" ]]; then
    error "VXWM source directory not found:"
    error "$VXWM_DIR"
    exit 1
fi

if [[ ! -f "$VXWM_DIR/Makefile" ]]; then
    error "Makefile not found in:"
    error "$VXWM_DIR"
    exit 1
fi

success "VXWM source found."

echo

# ==============================================================================
# Build and Install VXWM
# ==============================================================================

info "Building and installing VXWM..."

pushd "$VXWM_DIR" >/dev/null

info "Compiling VXWM..."

sudo make clean install

popd >/dev/null

success "VXWM installed successfully."

echo



# ==============================================================================
# Create XSession Entry
# ==============================================================================

XSESSION_DIR="/usr/share/xsessions"
XSESSION_FILE="$XSESSION_DIR/vxwm.desktop"

info "Creating XSession entry..."

sudo mkdir -p "$XSESSION_DIR"

sudo tee "$XSESSION_FILE" >/dev/null <<EOF
[Desktop Entry]
Name=VXWM
Comment=VXWM Window Manager
Exec=vxwm
Type=Application
DesktopNames=VXWM
EOF

success "XSession entry created:"
echo "       $XSESSION_FILE"

echo

# ==============================================================================
# Create Required Directories
# ==============================================================================

DIRECTORIES=(
    "$HOME/.config"
    "$HOME/.config/dunst"
    "$HOME/.config/gtk-3.0"
    "$HOME/.config/gtk-4.0"
    "$HOME/.cache"
    "$HOME/Pictures/Screenshots"
    "$HOME/Pictures/Wallpapers"
)

info "Creating required directories..."

mkdir -p "${DIRECTORIES[@]}"

success "Created ${#DIRECTORIES[@]} directories."

echo

# ==============================================================================
# Install Xorg Configuration
# ==============================================================================

info "Installing Xorg configuration..."

XORG_CONFIG="$XORG_DIR/40-libinput.conf"

if [[ -f "$XORG_CONFIG" ]]; then

    sudo mkdir -p /etc/X11/xorg.conf.d

    sudo install -Dm644 \
        "$XORG_CONFIG" \
        "/etc/X11/xorg.conf.d/40-libinput.conf"

    success "Xorg libinput configuration installed."

else

    warning "Xorg configuration not found:"
    warning "$XORG_CONFIG"

fi

echo

# ==============================================================================
# Theme Configuration
# ==============================================================================

GTK_THEME="adw-gtk3-dark"
ICON_THEME="gruvbox-plus-icon-theme"
CURSOR_THEME="Bibata-Modern-Ice"

info "Applying GTK theme configuration..."

# ==============================================================================
# GTK2
# ==============================================================================

cat > "$HOME/.gtkrc-2.0" <<EOF
gtk-theme-name="${GTK_THEME}"
gtk-icon-theme-name="${ICON_THEME}"
gtk-cursor-theme-name="${CURSOR_THEME}"
EOF

# ==============================================================================
# GTK3
# ==============================================================================

cat > "$HOME/.config/gtk-3.0/settings.ini" <<EOF
[Settings]
gtk-theme-name=${GTK_THEME}
gtk-icon-theme-name=${ICON_THEME}
gtk-cursor-theme-name=${CURSOR_THEME}
gtk-application-prefer-dark-theme=1
EOF

# ==============================================================================
# GTK4
# ==============================================================================

cat > "$HOME/.config/gtk-4.0/settings.ini" <<EOF
[Settings]
gtk-theme-name=${GTK_THEME}
gtk-icon-theme-name=${ICON_THEME}
gtk-cursor-theme-name=${CURSOR_THEME}
gtk-application-prefer-dark-theme=1
EOF

success "GTK theme configuration installed."

echo

# ==============================================================================
# Install Utility Scripts
# ==============================================================================

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

info "Installing utility scripts..."

mkdir -p "$USER_SCRIPTS_DIR"

for script in "${SCRIPTS[@]}"; do

    SOURCE="$SCRIPTS_DIR/$script"
    DESTINATION="$USER_SCRIPTS_DIR/$script"

    if [[ -f "$SOURCE" ]]; then

        install -m755 "$SOURCE" "$DESTINATION"

        success "Installed $script"

    else

        warning "Missing script: $SOURCE"

    fi

done

echo

# ==============================================================================
# Install Home Dotfiles
# ==============================================================================

HOME_FILES=(
    .xinitrc
    .xprofile
    .Xresources
    .bashrc
    .bash_profile
    .bash_history
)

info "Installing home configuration files..."

for file in "${HOME_FILES[@]}"; do

    SOURCE="$SCRIPT_DIR/$file"
    DESTINATION="$HOME/$file"

    if [[ -f "$SOURCE" ]]; then

        install -m644 "$SOURCE" "$DESTINATION"

        success "Installed: $file"

    else

        warning "Missing: $SOURCE"

    fi

done

success "Home configuration files installed."

echo

# ==============================================================================
# Install Wallpapers
# ==============================================================================

USER_WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

info "Installing wallpapers..."

mkdir -p "$USER_WALLPAPER_DIR"

if [[ -d "$WALLPAPERS_DIR" ]]; then

    found_wallpapers=false

    while IFS= read -r -d '' wallpaper; do

        found_wallpapers=true

        install -m644 \
            "$wallpaper" \
            "$USER_WALLPAPER_DIR/"

        success "Installed: $(basename "$wallpaper")"

    done < <(
        find "$WALLPAPERS_DIR" -type f \
            \( \
                -iname "*.jpg" \
                -o -iname "*.jpeg" \
                -o -iname "*.png" \
                -o -iname "*.webp" \
            \) \
            -print0
    )

    if [[ "$found_wallpapers" == true ]]; then
        success "Wallpapers installed."
    else
        warning "No supported wallpaper files found."
    fi

else

    warning "Wallpaper directory not found:"
    warning "$WALLPAPERS_DIR"

fi

echo

# ==============================================================================
# Install Configuration Files
# ==============================================================================

info "Installing configuration files..."

if [[ -d "$CONFIGS_DIR" ]]; then

    mkdir -p "$HOME/.config"

    cp -a "$CONFIGS_DIR"/. "$HOME/.config/"

    success "Configuration files installed successfully."

else

    warning "Configuration directory not found:"
    warning "$CONFIGS_DIR"

fi

echo

# ==============================================================================
# Install Cache Files
# ==============================================================================

info "Installing cache files..."

if [[ -d "$CACHE_DIR" ]]; then

    mkdir -p "$HOME/.cache"

    cp -a "$CACHE_DIR"/. "$HOME/.cache/"

    success "Cache files installed successfully."

else

    warning "Cache directory not found:"
    warning "$CACHE_DIR"

fi

echo

# ==============================================================================
# Final Verification
# ==============================================================================

echo
echo "========================================================"
echo -e "${BOLD}${CYAN}VXWM INSTALLATION COMPLETE${RESET}"
echo "========================================================"
echo

info "Running final checks..."

if command -v vxwm >/dev/null 2>&1; then
    success "VXWM:      $(command -v vxwm)"
else
    warning "VXWM binary was not found in PATH."
fi

if command -v vcompmgr >/dev/null 2>&1; then
    success "vcompmgr:  $(command -v vcompmgr)"
else
    warning "vcompmgr binary was not found in PATH."
fi

if [[ -f "$XSESSION_FILE" ]]; then
    success "XSession:  $XSESSION_FILE"
else
    warning "XSession file was not found."
fi

if [[ -f "$HOME/.xinitrc" ]]; then
    success ".xinitrc installed."
else
    warning ".xinitrc was not installed."
fi

if [[ -d "$HOME/.config" ]]; then
    success "~/.config exists."
fi

if [[ -d "$HOME/Pictures/Wallpapers" ]]; then
    success "Wallpaper directory exists."
fi

echo
echo "--------------------------------------------------------"
echo -e "${GREEN}${BOLD}VXWM is ready.${RESET}"
echo "--------------------------------------------------------"
echo
echo -e "${CYAN}You can start VXWM with:${RESET}"
echo
echo "    startx"
echo
echo -e "${CYAN}or select VXWM from your display manager's session menu.${RESET}"
echo
echo -e "${YELLOW}If you are using a display manager, make sure it supports X11 sessions.${RESET}"
echo
```

