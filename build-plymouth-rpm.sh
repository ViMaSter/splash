#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOPDIR="$ROOT_DIR/.rpmbuild"
PKG_NAME="runningbar-plymouth"
VERSION="1.0.0"
RELEASE="1"
SRCDIR="$TOPDIR/SOURCES/${PKG_NAME}-${VERSION}"

mkdir -p "$TOPDIR"/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
rm -rf "$SRCDIR"
mkdir -p "$SRCDIR"

cp -R "$ROOT_DIR/plymouth" "$SRCDIR/plymouth"
cp "$ROOT_DIR/LICENSE" "$SRCDIR/LICENSE"
cp "$ROOT_DIR/README-plymouth.md" "$SRCDIR/README-plymouth.md"

tar -C "$TOPDIR/SOURCES" -czf "$TOPDIR/SOURCES/${PKG_NAME}-${VERSION}.tar.gz" "${PKG_NAME}-${VERSION}"
cp "$ROOT_DIR/packaging/rpm/${PKG_NAME}.spec" "$TOPDIR/SPECS/${PKG_NAME}.spec"

rpmbuild -ba \
  --define "_topdir $TOPDIR" \
  "$TOPDIR/SPECS/${PKG_NAME}.spec"

mkdir -p "$ROOT_DIR/dist/rpms"
rm -rf "$ROOT_DIR/dist/rpms"/*
cp -R "$TOPDIR/RPMS"/* "$ROOT_DIR/dist/rpms/"

echo "Built RPM:"
find "$ROOT_DIR/dist/rpms" -type f -name "${PKG_NAME}-${VERSION}-${RELEASE}*.rpm" -print