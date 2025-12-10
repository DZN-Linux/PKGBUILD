# DZN Linux Package Versioning System

This document defines the versioning strategy for all DZN Linux packages in this repository.

## Version Format

DZN Linux packages use **Semantic Versioning 2.0.0** (semver.org):

```
MAJOR.MINOR.PATCH
```

- **MAJOR**: Incompatible changes (breaking changes)
- **MINOR**: New features (backwards-compatible)
- **PATCH**: Bug fixes (backwards-compatible)

### Examples
- `1.0.0` - Initial stable release
- `1.1.0` - Added new features
- `1.1.1` - Bug fixes
- `2.0.0` - Breaking changes

## Package Types

### Development Packages (-git)

Packages ending in `-git` track the latest development version from git:

**Package name format**: `<pkgname>-git`
**Version format**: `rNNN.SHORTHASH`

Example: `dznlinux-wallpapers-git` version `r47.a3f2c1d`

- `r47` - 47 commits in git history
- `a3f2c1d` - Short git commit hash

**PKGBUILD setup**:
```bash
pkgname=<package>-git
pkgver=r1.0
pkgrel=1

pkgver() {
  cd "${srcdir}/${_pkgname}"
  printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}
```

### Stable Packages

Stable release packages use semantic versioning:

**Package name format**: `<pkgname>`
**Version format**: `MAJOR.MINOR.PATCH`

Example: `dznlinux-wallpapers` version `1.0.0`

**PKGBUILD setup**:
```bash
pkgname=<package>
pkgver=1.0.0
pkgrel=1

source=("${pkgname}-${pkgver}.tar.gz::https://github.com/DZN-Linux/${pkgname}/archive/v${pkgver}.tar.gz")
sha256sums=('ACTUAL_SHA256_HASH')
```

## Package Release Number (pkgrel)

The `pkgrel` variable tracks packaging-only changes (no source code changes):

- Start at `1` for new package versions
- Increment when updating PKGBUILD, dependencies, or build process
- Reset to `1` when `pkgver` changes

**When to increment pkgrel**:
- Changed dependencies
- Modified install scripts
- Fixed packaging bugs
- Changed file permissions or locations
- Updated patches

**Example progression**:
```
pkgver=1.0.0  pkgrel=1  # Initial release
pkgver=1.0.0  pkgrel=2  # Fixed dependency issue
pkgver=1.0.0  pkgrel=3  # Updated install paths
pkgver=1.1.0  pkgrel=1  # New version (reset pkgrel)
```

## Version Management Workflow

### For -git Packages (Development)

1. **Initial setup**: Set `pkgver=r1.0` in PKGBUILD
2. **Automatic versioning**: `pkgver()` function updates version during build
3. **Package updates**: Only increment `pkgrel` for PKGBUILD changes
4. **Regenerate .SRCINFO**: `makepkg --printsrcinfo > .SRCINFO`

### For Stable Packages

1. **Create release in source repo**:
   ```bash
   cd <source-repo>
   git tag -a v1.0.0 -m "Release version 1.0.0"
   git push origin v1.0.0
   ```

2. **Update PKGBUILD**:
   - Update `pkgver=1.0.0`
   - Reset `pkgrel=1`
   - Update `source` URL to include version
   - Update `sha256sums` with actual hash

3. **Generate checksum**:
   ```bash
   makepkg -g  # Generates sha256sums
   ```

4. **Update .SRCINFO**:
   ```bash
   makepkg --printsrcinfo > .SRCINFO
   ```

5. **Test build and commit**:
   ```bash
   makepkg -si
   git add PKGBUILD .SRCINFO
   git commit -m "Update to version 1.0.0"
   git push
   ```

## Version Bumping Guidelines

### When to bump MAJOR version (X.0.0)
- Breaking API changes
- Removed features or files
- Changed file paths that break existing configs
- Incompatible with previous version

### When to bump MINOR version (0.X.0)
- New wallpapers/themes added (for wallpaper packages)
- New features
- New optional dependencies
- Backwards-compatible changes

### When to bump PATCH version (0.0.X)
- Bug fixes
- Performance improvements
- Documentation updates
- Security fixes (non-breaking)

## Package Naming Convention

```
<distribution>-<package>[-variant][-git]
```

Examples:
- `dznlinux-wallpapers` - Stable wallpaper package
- `dznlinux-wallpapers-git` - Development wallpaper package
- `dznlinux-themes` - Stable theme package
- `dznlinux-themes-dark` - Dark variant of themes
- `dznlinux-config-hyprland` - Hyprland configuration

## Version File in Source Repository

For stable releases, maintain a `VERSION` file in the source repository:

**Location**: `<source-repo>/VERSION`

**Format**:
```
1.0.0
```

**Usage in PKGBUILD**:
```bash
pkgver() {
  cd "${srcdir}/${_pkgname}"
  cat VERSION
}
```

This allows version to be tracked in source repository and automatically used during build.

## Release Checklist

### For Stable Release

- [ ] Update VERSION file in source repo
- [ ] Update CHANGELOG in source repo
- [ ] Create git tag in source repo: `git tag -a v1.0.0`
- [ ] Push tag: `git push origin v1.0.0`
- [ ] Update PKGBUILD `pkgver`
- [ ] Reset PKGBUILD `pkgrel=1`
- [ ] Generate checksums: `makepkg -g`
- [ ] Update .SRCINFO: `makepkg --printsrcinfo > .SRCINFO`
- [ ] Test build: `makepkg -si`
- [ ] Commit and push PKGBUILD changes
- [ ] Submit to AUR (if applicable)

### For -git Package Update

- [ ] Update dependencies if needed
- [ ] Increment `pkgrel` if PKGBUILD changed
- [ ] Update .SRCINFO: `makepkg --printsrcinfo > .SRCINFO`
- [ ] Test build: `makepkg -si`
- [ ] Commit and push

## Version Tracking Script

Use this script to check current versions across all packages:

```bash
#!/bin/bash
# check-versions.sh

echo "DZN Linux Package Versions"
echo "=========================="

for dir in */; do
    if [ -f "${dir}PKGBUILD" ]; then
        pkgname=$(grep "^pkgname=" "${dir}PKGBUILD" | cut -d'=' -f2)
        pkgver=$(grep "^pkgver=" "${dir}PKGBUILD" | cut -d'=' -f2)
        pkgrel=$(grep "^pkgrel=" "${dir}PKGBUILD" | cut -d'=' -f2)
        echo "${pkgname}: ${pkgver}-${pkgrel}"
    fi
done
```

## Examples

### Example 1: dznlinux-wallpapers-git (Current)

```bash
pkgname=dznlinux-wallpapers-git
_pkgname=dznlinux-wallpapers
pkgver=r1.0                    # Placeholder
pkgrel=1
provides=('dznlinux-wallpapers')
conflicts=('dznlinux-wallpapers')

pkgver() {
  cd "${srcdir}/${_pkgname}"
  printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}
```

### Example 2: dznlinux-wallpapers (Stable - Future)

```bash
pkgname=dznlinux-wallpapers
pkgver=1.0.0
pkgrel=1

source=("${pkgname}-${pkgver}.tar.gz::https://github.com/DZN-Linux/${pkgname}/archive/v${pkgver}.tar.gz")
sha256sums=('abc123...')
```

### Example 3: Using VERSION file

**Source repo (dznlinux-wallpapers/VERSION)**:
```
1.0.0
```

**PKGBUILD**:
```bash
pkgname=dznlinux-wallpapers
pkgver=1.0.0
pkgrel=1

pkgver() {
  cd "${srcdir}/${pkgname}"
  cat VERSION
}

source=("${pkgname}::git+https://github.com/DZN-Linux/${pkgname}.git#tag=v${pkgver}")
```

## Summary

- **Development**: Use `-git` suffix with auto-generated `rNNN.HASH` versions
- **Stable**: Use semantic versioning `MAJOR.MINOR.PATCH`
- **Packaging**: Use `pkgrel` for PKGBUILD-only changes
- **Source repos**: Tag releases as `vMAJOR.MINOR.PATCH`
- **Always**: Update .SRCINFO after PKGBUILD changes
