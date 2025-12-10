# Build Instructions

This document provides instructions for building, installing, and maintaining the dznlinux-wallpapers package.

## Prerequisites

Ensure you have the following packages installed:

```bash
sudo pacman -S base-devel git
```

## Building the Package

### 1. Clone the Repository

```bash
git clone https://github.com/DZN-Linux/dznlinux-wallpapers.git
cd dznlinux-wallpapers
```

### 2. Build the Package

```bash
makepkg -sf
```

**Options:**
- `-s` - Install missing dependencies
- `-f` - Force overwrite of existing package
- `-c` - Clean up work files after build

### 3. Install the Package

After building, install the package:

```bash
makepkg -si
```

**Or install manually:**

```bash
sudo pacman -U dznlinux-wallpapers-git-*.pkg.tar.zst
```

## Quick Build & Install (One Command)

To build and install in one step:

```bash
makepkg -si
```

**Options:**
- `-s` - Sync and install missing dependencies
- `-i` - Install package after successful build

## Updating .SRCINFO

The `.SRCINFO` file must be updated whenever you make changes to the `PKGBUILD`. This file is required for AUR submissions.

### Update .SRCINFO

```bash
makepkg --printsrcinfo > .SRCINFO
```

### When to Update .SRCINFO

Update `.SRCINFO` after modifying any of the following in `PKGBUILD`:
- Package name or version
- Dependencies
- Package description
- Source URLs
- Architecture
- License

### Commit Both Files

Always commit both `PKGBUILD` and `.SRCINFO` together:

```bash
git add PKGBUILD .SRCINFO
git commit -m "Update package to version X.Y.Z"
git push
```

## Testing the Package

### 1. Verify Package Contents

After building, inspect the package contents:

```bash
tar -tvf dznlinux-wallpapers-git-*.pkg.tar.zst
```

### 2. Verify Installation

After installing, verify files are in the correct locations:

```bash
ls /usr/share/backgrounds/dznlinux/
ls /usr/share/wallpapers/DZNLinux/
```

### 3. Test Wallpapers

**KDE Plasma:**
1. Right-click desktop → Configure Desktop and Wallpaper
2. Browse to `/usr/share/backgrounds/dznlinux/`
3. Select a wallpaper to verify it loads correctly

**Hyprland:**
```bash
hyprpaper -c <(echo "preload = /usr/share/backgrounds/dznlinux/default.jpg
wallpaper = ,/usr/share/backgrounds/dznlinux/default.jpg")
```

## Cleaning Up

### Remove Build Artifacts

```bash
git clean -fdx
```

**Warning:** This removes all untracked files. Use with caution.

### Remove Only Build Files

```bash
rm -rf src/ pkg/ *.pkg.tar.zst
```

## Uninstalling

To remove the package:

```bash
sudo pacman -R dznlinux-wallpapers-git
```

## Troubleshooting

### Build Fails with Missing Dependencies

```bash
makepkg -s
```

The `-s` flag automatically installs missing dependencies.

### Permission Denied Errors

Ensure you're not running `makepkg` as root:

```bash
makepkg
```

Use `sudo` only for installation:

```bash
sudo pacman -U *.pkg.tar.zst
```

### .SRCINFO is Outdated

If you see warnings about outdated `.SRCINFO`:

```bash
makepkg --printsrcinfo > .SRCINFO
git add .SRCINFO
git commit -m "Update .SRCINFO"
```

## Publishing to AUR

### 1. Update Package Version

Update `pkgver` or `pkgrel` in `PKGBUILD` if needed.

### 2. Update .SRCINFO

```bash
makepkg --printsrcinfo > .SRCINFO
```

### 3. Commit Changes

```bash
git add PKGBUILD .SRCINFO
git commit -m "Update to version X.Y.Z"
```

### 4. Push to AUR

```bash
git push aur master
```

## Additional Resources

- [Arch Wiki - PKGBUILD](https://wiki.archlinux.org/title/PKGBUILD)
- [Arch Wiki - Makepkg](https://wiki.archlinux.org/title/Makepkg)
- [Arch Wiki - AUR Submission Guidelines](https://wiki.archlinux.org/title/AUR_submission_guidelines)
- [DZN Linux Documentation](https://github.com/DZN-Linux)

## Support

For issues or questions:
- Open an issue: https://github.com/DZN-Linux/dznlinux-wallpapers/issues
- DZN Linux Community: [Add community links]
