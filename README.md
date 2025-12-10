# DZN Linux PKGBUILD Repository

Official Arch Linux package repository for DZN Linux packages.

## Quick Start

### Build a Package

```bash
cd dznlinux-wallpapers
makepkg -si
```

### Check All Package Versions

```bash
./check-versions.sh
```

### Create New Package

```bash
# For development version (-git)
mkdir my-package
cp PKGBUILD.template-git my-package/PKGBUILD
cd my-package
# Edit PKGBUILD and replace PACKAGE_NAME, PACKAGE_DESCRIPTION
makepkg --printsrcinfo > .SRCINFO
makepkg -si
```

## Documentation

- **BUILD.md** - Detailed build and maintenance instructions
- **VERSIONING.md** - Complete version management system and guidelines
- **CLAUDE.md** - AI assistant guidance for working with this repository
- **check-versions.sh** - Script to display versions of all packages

## Repository Structure

This repository contains PKGBUILD files for AUR (Arch User Repository) distribution. Each package directory contains:

- `PKGBUILD` - Arch package build script
- `.SRCINFO` - Auto-generated metadata (required for AUR)
- `README.md` - Package-specific documentation
- `LICENSE` - Package license
- `.gitignore` - Build artifact exclusions

## Current Packages

### dznlinux-wallpapers-git

Wallpaper collection for DZN Linux (115 high-quality wallpapers)

**Installation:**
```bash
cd dznlinux-wallpapers
makepkg -si
```

## Versioning System

DZN Linux packages use **Semantic Versioning** (MAJOR.MINOR.PATCH):

- **-git packages**: Auto-versioned as `rNNN.HASH` (development versions)
- **Stable packages**: Versioned as `1.0.0`, `1.1.0`, `2.0.0`, etc.

**See VERSIONING.md for complete guidelines.**

## Essential Commands

```bash
# Build package
makepkg -sf

# Build and install
makepkg -si

# Update .SRCINFO (ALWAYS do this after editing PKGBUILD)
makepkg --printsrcinfo > .SRCINFO

# Check package versions
./check-versions.sh

# Clean build artifacts
rm -rf src/ pkg/ *.pkg.tar.zst
```

## Contributing

### Adding a New Package

1. Create source repository at `https://github.com/DZN-Linux/<package-name>`
2. Create package directory: `mkdir <package-name>`
3. Copy template: `cp PKGBUILD.template-git <package-name>/PKGBUILD`
4. Edit PKGBUILD with package details
5. Generate .SRCINFO: `cd <package-name> && makepkg --printsrcinfo > .SRCINFO`
6. Test build and install
7. Create README.md for the package
8. Commit and push

### Updating a Package

1. Edit PKGBUILD (version, dependencies, etc.)
2. **Update .SRCINFO**: `makepkg --printsrcinfo > .SRCINFO`
3. Test build: `makepkg -sf`
4. Commit both files: `git add PKGBUILD .SRCINFO && git commit -m "Update package"`

## Package Templates

- **PKGBUILD.template-git** - Template for development packages (-git suffix)
- **PKGBUILD.template-stable** - Template for stable release packages

Replace `PACKAGE_NAME` and `PACKAGE_DESCRIPTION` placeholders when using templates.

## Links

- **DZN Linux**: https://github.com/DZN-Linux
- **Source Repositories**: https://github.com/DZN-Linux/<package-name>
- **Arch Wiki - PKGBUILD**: https://wiki.archlinux.org/title/PKGBUILD
- **Arch Wiki - AUR**: https://wiki.archlinux.org/title/AUR_submission_guidelines

## License

Individual packages have their own licenses. See LICENSE file in each package directory.

## Maintainer

Seth Dawson <dznlinux@gmail.com>
