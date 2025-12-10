# dznlinux-splash-dark-plasma-git

DZN-Linux Dark Splash Screen for Plasma 6

## Overview

A custom dark-themed splash screen for KDE Plasma 6 featuring the DZN-Linux branding with animated logo display.

## Features

- **Plasma 6 Compatible**: Uses Qt 6 and modern Plasma metadata format
- **Dark Theme**: Dark gray background (#313131) with smooth animations
- **Animated Logo**: Displays animated GIF logo during boot
- **Smooth Transitions**: Fade-in/fade-out opacity animations
- **Loading Indicator**: Rotating busy indicator with progress feedback

## Installation

### From Package (Recommended)

If DZN Linux repository is configured:
```bash
sudo pacman -S dznlinux-splash-dark-plasma-git
```

### Manual Build

```bash
git clone https://github.com/DZN-Linux/DZN-Linux.git
cd DZN-Linux/PKGBUILD/dznlinux-splash-dark-plasma
makepkg -si
```

## Usage

After installation, activate the splash screen:

1. Open **System Settings** → **Appearance** → **Splash Screen**
2. Select **dznlinux-Splash-Dark**
3. Click **Apply**

The splash screen will appear during Plasma startup.

## Package Contents

- `/usr/share/plasma/look-and-feel/dznlinux-Splash-Dark/` - Splash screen files
  - `metadata.json` - Plasma 6 package metadata
  - `metadata.desktop` - Legacy metadata (backward compatibility)
  - `contents/splash/Splash.qml` - Main splash screen QML file
  - `contents/splash/images/` - Graphics and animations
  - `contents/previews/` - Preview images

## Technical Details

- **QML Framework**: Qt 6 with QtQuick
- **Animation Engine**: QtQuick.Window with smooth opacity transitions
- **Progress Tracking**: Stage-based loading with 5 distinct phases
- **Resolution Support**: Adaptive layout that scales to any screen size

## Dependencies

- `plasma-workspace` - KDE Plasma workspace

## Building

```bash
makepkg -si
```

## Version

Current version is tracked via git commits using the format `rNNN.HASH` where:
- `NNN` = Number of commits
- `HASH` = Short git commit hash

## License

GPL-3.0 - See LICENSE file

## Source

Part of the DZN-Linux project: https://github.com/DZN-Linux/DZN-Linux
