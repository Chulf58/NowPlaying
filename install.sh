#!/usr/bin/env bash
# Installs Now Playing for the current user: script, Python venv and launcher.
set -euo pipefail
cd "$(dirname "$0")"

BIN="$HOME/.local/bin/nowplaying"
VENV="$HOME/.local/share/nowplaying/venv"
DESKTOP="$HOME/.local/share/applications/nowplaying.desktop"

for cmd in python3 cava playerctl ghostty youtube-music; do
    command -v "$cmd" >/dev/null || echo "warning: '$cmd' not found (see README)"
done

mkdir -p "$(dirname "$BIN")" "$(dirname "$DESKTOP")"
install -m 755 nowplaying "$BIN"

python3 -m venv "$VENV"
"$VENV/bin/pip" install --quiet --upgrade pip
"$VENV/bin/pip" install --quiet -r requirements.txt

sed "s|@BIN@|$BIN|" nowplaying.desktop.in > "$DESKTOP"
update-desktop-database "$(dirname "$DESKTOP")" 2>/dev/null || true

echo "Installed. Start it with 'nowplaying' or from the app menu (Now Playing)."
