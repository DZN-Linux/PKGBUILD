# dznlinux-wallpapers

Wallpaper collection for DZN Linux

## Overview

Collection of 115 high-quality wallpapers in various resolutions (1080p, 1440p, 4K, 5K) for use with Arch Linux desktop environments.

## Contents

- 115 wallpapers in JPG and PNG formats
- Resolutions: 1920x1080 to 5000x3535
- Total size: ~152MB
- Themes: Nature, space, abstract, cyberpunk, Arch Linux branded

## Installation

### From Package (Recommended)

If DZN Linux repository is configured:
```bash
sudo pacman -S dznlinux-wallpapers-git
```

### Manual Installation

```bash
sudo cp -r usr/share/backgrounds/dznlinux /usr/share/backgrounds/
sudo cp -r usr/share/wallpapers/DZNLinux /usr/share/wallpapers/
```

## Usage

### KDE Plasma

1. Right-click desktop → Configure Desktop and Wallpaper
2. Click "Get New Wallpapers" or browse to `/usr/share/backgrounds/dznlinux/`
3. Select any wallpaper

Wallpapers are automatically available in the wallpaper selector.

### Hyprland

Add to `~/.config/hypr/hyprpaper.conf`:
```
preload = /usr/share/backgrounds/dznlinux/default.jpg
wallpaper = ,/usr/share/backgrounds/dznlinux/default.jpg
```

Or use with `swaybg`:
```bash
swaybg -i /usr/share/backgrounds/dznlinux/default.jpg
```

### Other Desktop Environments

Wallpapers are installed to standard location `/usr/share/backgrounds/dznlinux/` and can be used with any desktop environment or wallpaper manager.

## Building Package

```bash
makepkg -si
```

## License

GPL - See LICENSE file
