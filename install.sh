#!/bin/bash
# Installs the bt-battery block into the user's Regolith 3 i3xrocks config.
set -e
SRC="$(cd "$(dirname "$0")" && pwd)"
DEST="$HOME/.config/regolith3/i3xrocks"

mkdir -p "$DEST/scripts" "$DEST/conf.d"
install -m 755 "$SRC/scripts/bt-battery" "$DEST/scripts/bt-battery"
install -m 644 "$SRC/conf.d/85_bt-battery" "$DEST/conf.d/85_bt-battery"

# A user conf.d directory hides the default blocks, so link them in
# (existing files are left alone).
for f in /usr/share/i3xrocks/conf.d/*; do
    [ -e "$DEST/conf.d/$(basename "$f")" ] || ln -s "$f" "$DEST/conf.d/$(basename "$f")"
done

echo "Installed. Run 'i3-msg restart' to reload the bar."
