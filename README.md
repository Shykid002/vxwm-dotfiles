# vxwm-dotfiles

Personal dotfiles and installer for VXWM (a fork of dwm) and a lightweight X11 desktop setup.

This repository contains my VXWM configuration, utilities, themes, and an installer script that automates installing dependencies, building vxwm and vcompmgr, setting up configuration files, copying wallpapers, and enabling a few services. Use at your own risk — review the installer before running, especially because it uses sudo and pacman/paru.

## Highlights

- Automated installer (install.sh) for Arch-based systems.
- vxwm source and build integration.
- Utility scripts (brightness, volume, wallpaper switching, etc.).
- GTK theme configuration and Xorg settings for touchpad.
- Wallpapers, user config files, and caches packaged for easy deployment.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Quick Install (Arch)](#quick-install-arch)
- [Manual Installation](#manual-installation)
- [Files & Structure](#files--structure)
- [Usage](#usage)
- [Customization & Configuration](#customization--configuration)
- [Security / Safety Notes](#security--safety-notes)
- [Contributing](#contributing)
- [License](#license)

## Prerequisites

This installer assumes an Arch-based distribution (pacman + AUR). It uses:

- sudo
- pacman
- git
- make
- gcc / build tools
- rust (for building paru, if not present)
- paru (AUR helper — installer will build it if missing)

If you are not using Arch/Manjaro, inspect the scripts and install required packages with your distro's package manager. The included `vxwm` subdirectory contains vxwm source and its README explaining build dependencies (Xlib, Xft, Xinerama headers, etc.).

## Quick Install (Arch)

1. Clone this repo:
   git clone https://github.com/Shykid002/vxwm-dotfiles.git
   cd vxwm-dotfiles

2. (Recommended) Review `install.sh` and the `pkgs/` lists to ensure packages are acceptable.

3. Run the installer:
   sudo ./install.sh

The script will:
- Install official packages (from pkgs/pacman_pkgs.txt)
- Install AUR packages using paru (from pkgs/paru_pkgs.txt)
- Build and install vxwm and vcompmgr from the included source directories
- Create required directories in your home (~/.config, ~/.cache, Pictures etc.)
- Copy dotfiles (.xinitrc, .xprofile, .Xresources, .bashrc, .bash_profile) to $HOME
- Install utility scripts to ~/scripts
- Install wallpapers to ~/Pictures/Wallpapers
- Install Xorg touchpad config to /etc/X11/xorg.conf.d/40-libinput.conf
- Enable some systemd services (tlp, mbpfan) and configure Ly display manager

## Manual Installation

If you prefer manual control:

- Install dependencies from the package lists in pkgs/
- Build vxwm:
  cd vxwm
  make
  sudo make clean install

- Build vcompmgr:
  cd ../vcompmgr
  make
  sudo make clean install

- Copy configuration files from `configs/` into `~/.config/`, scripts from `scripts/` into `~/scripts`, wallpapers from `wallpapers/` into `~/Pictures/Wallpapers`, and the dotfiles (.xinitrc, .xprofile, .Xresources, .bashrc, .bash_profile) into your home directory.

## Files & Structure

- install.sh — Main installer script (Arch-centric).
- pkgs/ — Package lists used by install.sh (pacman & paru).
- vxwm/ — vxwm window manager source (README inside).
- vcompmgr — compositor source (Makefile expected).
- scripts/ — Utility scripts installed to ~/scripts (brightness, volume, rofi-wallpaper, etc.).
- configs/ — Configuration directories/files to copy into ~/.config.
- wallpapers/ — Wallpaper images.
- xorg-touch-pad/ — Xorg config for touchpad (40-libinput.conf).
- assets/ — Screenshots and other assets.
- .xinitrc, .xprofile, .Xresources, .bashrc, .bash_profile — Home dotfiles.

## Usage

- Start the WM with startx (ensure `.xinitrc` runs `exec vxwm`).
- You can restart vxwm using the rvx utility if included, or by relaunching the session.
- The installer configures GTK themes and icon/cursor themes; adjust the names in the script or your config files if you prefer different themes.

## Customization & Configuration

- vxwm configuration: edit `vxwm/config.h` and `vxwm/modules.h` and recompile to apply changes.
- Utility scripts: `scripts/` contains a number of small helper scripts you can modify.
- Theme settings inside install.sh use:
  - GTK_THEME="adw-gtk3-dark"
  - ICON_THEME="gruvbox-plus-icon-theme"
  - CURSOR_THEME="Bibata-Modern-Ice"

## Security / Safety Notes

- The installer uses sudo and will install system packages, enable services, and write to system directories. Inspect `install.sh` and package lists before running.
- The script clones and builds paru from AUR; building AUR packages runs code on your machine — review before use.
- Back up important files before running the installer.

## Contributing

- If you find issues or want changes, please open an issue or a pull request.
- For repo-specific discussions or help, provide logs and steps to reproduce.

## License

This repository is licensed under the MIT License. See the LICENSE file for details.
