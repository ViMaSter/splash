#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_ID="org.vimaster.runningbar"
THEME_NAME="Running Bar"
SOURCE_DIR="$SCRIPT_DIR"
USER_TARGET="$HOME/.local/share/plasma/look-and-feel/$THEME_ID"
SYSTEM_TARGET="/usr/share/plasma/look-and-feel/$THEME_ID"

print_usage() {
  cat <<EOF
Install KDE splash theme: $THEME_NAME

Usage:
  ./install-splash.sh            Install for current user
  ./install-splash.sh --system   Install system-wide (requires sudo)
  ./install-splash.sh --help     Show this help
EOF
}

copy_theme() {
  local target_dir="$1"

  mkdir -p "$target_dir"

  # Copy required theme files from this script's directory.
  cp -f "$SOURCE_DIR/metadata.json" "$target_dir/metadata.json"
  mkdir -p "$target_dir/contents/splash"
  cp -f "$SOURCE_DIR/contents/splash/Splash.qml" "$target_dir/contents/splash/Splash.qml"
}

if [[ ! -f "$SOURCE_DIR/metadata.json" ]] || [[ ! -f "$SOURCE_DIR/contents/splash/Splash.qml" ]]; then
  echo "Error: expected metadata.json and contents/splash/Splash.qml next to this script."
  exit 1
fi

mode="user"

case "${1:-}" in
  "")
    mode="user"
    ;;
  --system)
    mode="system"
    ;;
  --help|-h)
    print_usage
    exit 0
    ;;
  *)
    echo "Unknown option: $1"
    print_usage
    exit 1
    ;;
esac

if [[ "$mode" == "user" ]]; then
  echo "Installing $THEME_NAME for current user..."
  copy_theme "$USER_TARGET"
  echo "Installed to: $USER_TARGET"
  echo "Open System Settings -> Appearance -> Splash Screen and select '$THEME_NAME'."
else
  echo "Installing $THEME_NAME system-wide..."
  if [[ "$EUID" -ne 0 ]]; then
    exec sudo "$0" --system
  fi
  copy_theme "$SYSTEM_TARGET"
  echo "Installed to: $SYSTEM_TARGET"
  echo "Open System Settings -> Appearance -> Splash Screen and select '$THEME_NAME'."
fi
