# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is an Arch Linux PKGBUILD repository for DZN Linux packages intended for AUR (Arch User Repository) distribution. It contains packaging metadata that builds packages from separate source repositories.

**See VERSIONING.md for complete version management guidelines.**

## Architecture

### Two-Repository Structure

This repository follows the standard AUR pattern where **packaging** and **source code** are separated:

- **This repo (PKGBUILD/)**: Contains AUR packaging files (PKGBUILD, .SRCINFO, etc.)
- **Source repos**: Separate repositories containing actual package content (e.g., `dznlinux-wallpapers` at https://github.com/DZN-Linux/dznlinux-wallpapers)

The PKGBUILD files reference source repositories via git URLs. During build, `makepkg` clones the source repo into a temporary directory, then packages its contents.

### Directory Structure

```
PKGBUILD/
├── BUILD.md                      # Detailed build/maintenance guide
├── VERSIONING.md                 # Version management system
├── CLAUDE.md                     # This file
├── check-versions.sh             # Script to check all package versions
├── PKGBUILD.template-git         # Template for -git packages
├── PKGBUILD.template-stable      # Template for stable packages
└── <package-name>/               # One directory per package
    ├── PKGBUILD                  # Arch package build script
    ├── .SRCINFO                  # Auto-generated metadata (for AUR)
    ├── README.md                 # Package-specific documentation
    ├── LICENSE                   # Package license
    └── .gitignore                # Excludes build artifacts
```

## Essential Commands

### Building Packages

```bash
# Build package (without installing)
makepkg -sf

# Build and install in one step
makepkg -si

# Options:
# -s: Install missing dependencies
# -i: Install after building
# -f: Force overwrite existing package
# -c: Clean up work files after build
```

### Maintaining .SRCINFO

**Critical**: `.SRCINFO` MUST be updated after ANY PKGBUILD changes. This file is required for AUR submissions.

```bash
# Regenerate .SRCINFO from PKGBUILD
makepkg --printsrcinfo > .SRCINFO

# Always commit both together
git add PKGBUILD .SRCINFO
git commit -m "Update package"
```

### Package Verification

```bash
# Inspect built package contents
tar -tvf <package-name>-*.pkg.tar.zst

# Verify installation paths
ls /usr/share/backgrounds/dznlinux/     # For wallpapers package
ls /usr/share/wallpapers/DZNLinux/      # KDE metadata
```

### Cleanup

```bash
# Remove build artifacts only
rm -rf src/ pkg/ *.pkg.tar.zst

# Nuclear option (removes ALL untracked files)
git clean -fdx
```

### Version Management

```bash
# Check versions of all packages
./check-versions.sh

# View versioning guidelines
cat VERSIONING.md
```

**Versioning Quick Reference:**
- **-git packages**: Auto-versioned as `rNNN.HASH` (development)
- **Stable packages**: Use semantic versioning `MAJOR.MINOR.PATCH`
- **pkgrel**: Increment for PKGBUILD-only changes, reset to 1 on version bump
- **Always update .SRCINFO** after changing `pkgver` or `pkgrel`

See VERSIONING.md for complete guidelines.

## PKGBUILD Conventions

### Version Numbering for -git Packages

Packages ending in `-git` use auto-generated versions via the `pkgver()` function:

```bash
pkgver() {
  cd "${srcdir}/${_pkgname}"
  printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}
```

This creates versions like `r123.abc1234` (r = revision count, abc1234 = short commit hash).

### Standard Variables

- `pkgname`: Full package name (e.g., `dznlinux-wallpapers-git`)
- `_pkgname`: Base name without suffix (e.g., `dznlinux-wallpapers`)
- `provides`: Virtual package name for dependency resolution
- `conflicts`: Prevents installation alongside conflicting packages

### Installation Paths

DZN Linux packages use standard FHS paths:
- `/usr/share/backgrounds/dznlinux/` - Wallpapers
- `/usr/share/wallpapers/DZNLinux/` - KDE Plasma wallpaper metadata
- `/usr/share/doc/<package>/` - Documentation

## Key Files

### PKGBUILD

The core build script. Uses Bash syntax with special functions:
- `pkgver()`: Auto-generates version from git
- `package()`: Installs files into `${pkgdir}` (staging directory)

Always use `install -Dm644` for files and `install -dm755` for directories to ensure proper permissions.

### .SRCINFO

Auto-generated machine-readable metadata. **Never edit manually**. Always regenerate with `makepkg --printsrcinfo > .SRCINFO` after PKGBUILD changes.

Contains: package name, description, version, dependencies, source URLs, checksums, architecture, license.

## Workflow for New Packages

1. Create package directory: `mkdir <package-name>`
2. Copy appropriate template:
   - For development: `cp PKGBUILD.template-git <package-name>/PKGBUILD`
   - For stable: `cp PKGBUILD.template-stable <package-name>/PKGBUILD`
3. Edit PKGBUILD and replace placeholders:
   - `PACKAGE_NAME` - Package name
   - `PACKAGE_DESCRIPTION` - Short description
   - Add dependencies, install logic, etc.
4. Generate .SRCINFO: `cd <package-name> && makepkg --printsrcinfo > .SRCINFO`
5. Add .gitignore (copy from existing package)
6. Test build: `makepkg -sf`
7. Verify contents: `tar -tvf *.pkg.tar.zst`
8. Test install: `makepkg -si`
9. Create README.md describing the package
10. Commit: `git add . && git commit -m "Add <package-name>"`

## Workflow for Updating Packages

1. Edit PKGBUILD (change dependencies, paths, version, etc.)
2. **Critical**: Regenerate .SRCINFO: `makepkg --printsrcinfo > .SRCINFO`
3. Test build: `makepkg -sf`
4. Verify and test install
5. Commit both: `git add PKGBUILD .SRCINFO && git commit -m "Update <package>"`

## Common Pitfalls

- **Forgetting to update .SRCINFO**: AUR will reject your submission
- **Running makepkg as root**: Will fail with permission errors. Always run as normal user
- **Wrong source paths**: Ensure git URLs point to correct repository
- **Hardcoded versions in -git packages**: Use `pkgver()` function for auto-versioning
- **Improper permissions**: Use `install` command, not `cp`, for proper ownership/permissions

## Package-Specific Notes

### dznlinux-wallpapers-git

- Sources from: https://github.com/DZN-Linux/dznlinux-wallpapers
- Installs 115 wallpapers (~152MB)
- Supports KDE Plasma and Hyprland
- Paths: `/usr/share/backgrounds/dznlinux/` and `/usr/share/wallpapers/DZNLinux/`
- Test with: `ls /usr/share/backgrounds/dznlinux/ | wc -l` (should show 115)

## Resources

- BUILD.md: Comprehensive build/maintenance instructions
- [Arch Wiki - PKGBUILD](https://wiki.archlinux.org/title/PKGBUILD)
- [Arch Wiki - AUR Submission Guidelines](https://wiki.archlinux.org/title/AUR_submission_guidelines)
- Package READMEs: User-facing documentation in each package subdirectory
