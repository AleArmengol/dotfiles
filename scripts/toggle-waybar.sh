#!/usr/bin/env bash
set -euo pipefail

DF="$HOME/dotfiles"
ORIG="$DF/waybar/.config/waybar"
MECHA="$DF/waybar-mechabar/.config/waybar"
TARGET="$HOME/.config/waybar"

err() { echo "❌ ERROR: $*" >&2; exit 1; }

need_conf() {
  [[ -f "$1/config" || -f "$1/config.jsonc" ]] || return 1
}

[[ -d "$ORIG" ]] || err "Original package folder missing: $ORIG"
[[ -d "$MECHA" ]] || err "Mechabar package folder missing: $MECHA"

CURRENT=$(readlink -f "$TARGET" 2>/dev/null || true)

if [[ "$CURRENT" == "$(readlink -f "$MECHA")" ]]; then
  echo "🔁 Switching to ORIGINAL Waybar..."
  need_conf "$ORIG" || err "Original config missing (no config/config.jsonc in $ORIG)"
  stow -D -t ~ waybar-mechabar
  stow -t ~ waybar
else
  echo "🔁 Switching to MECHABAR..."
  need_conf "$MECHA" || err "Mechabar config incomplete (no config/config.jsonc in $MECHA)"
  stow -D -t ~ waybar || true
  stow -t ~ waybar-mechabar
fi

# Relaunch Waybar safely
killall waybar 2>/dev/null || true
sleep 0.3

if [[ -f "$TARGET/config.jsonc" ]]; then
  waybar -c "$TARGET/config.jsonc" -s "$TARGET/style.css" & disown
elif [[ -f "$TARGET/config" ]]; then
  waybar -c "$TARGET/config" -s "$TARGET/style.css" & disown
else
  err "No config found under $TARGET"
fi

FINAL=$(readlink -f "$TARGET")
echo "✅ Active config: $FINAL"

