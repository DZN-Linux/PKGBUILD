#!/bin/bash
# check-versions.sh
# Display current versions of all DZN Linux packages

echo "======================================"
echo "  DZN Linux Package Versions"
echo "======================================"
echo ""

found_packages=0

for dir in */; do
    if [ -f "${dir}PKGBUILD" ]; then
        # Extract package info
        pkgname=$(grep "^pkgname=" "${dir}PKGBUILD" | cut -d'=' -f2)
        pkgver=$(grep "^pkgver=" "${dir}PKGBUILD" | cut -d'=' -f2)
        pkgrel=$(grep "^pkgrel=" "${dir}PKGBUILD" | cut -d'=' -f2)
        pkgdesc=$(grep "^pkgdesc=" "${dir}PKGBUILD" | cut -d'"' -f2)

        # Display info
        echo "Package: ${pkgname}"
        echo "Version: ${pkgver}-${pkgrel}"
        [ -n "$pkgdesc" ] && echo "Description: ${pkgdesc}"
        echo ""

        ((found_packages++))
    fi
done

if [ $found_packages -eq 0 ]; then
    echo "No packages found in current directory."
    echo ""
fi

echo "======================================"
echo "Total packages: ${found_packages}"
echo "======================================"
