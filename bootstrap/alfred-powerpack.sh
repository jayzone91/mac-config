#!/usr/bin/env bash

set -euo pipefail

SECRET="/run/secrets/alfred/powerpack_license"
ALFRED_APP="$(
  find /Applications \
    -maxdepth 1 \
    -type d \
    -name 'Alfred*.app' \
    -print \
    -quit
)"

if [[ ! -r "$SECRET" ]]; then
    echo "Alfred Powerpack secret not readable: $SECRET"
    exit 1
fi

if [[ -z "$ALFRED_APP" ]]; then
  echo "Alfred application not found in /Applications"
  exit 1
fi

pbcopy < "$SECRET"

echo "Alfred Powerpack license copied to clipboard."
echo "Opening Alfred preferences..."

open "$ALFRED_APP"

echo
echo "Open:"
echo "  Alfred Settings -> Powerpack"
echo
echo "Paste the license with Cmd+V and activate it."
echo
echo "Press Enter after activation to clear the clipboard."
read -r

printf '' | pbcopy

echo "Clipboard cleared."