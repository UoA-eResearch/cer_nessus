#!/bin/bash

cd "$(dirname "$0")" || exit 1

source functions.sh

# Check if the new install_agent.sh script is different from the last known hash
HASH_NEW=$(sha256sum "$DIR_SRC/install_agent.sh" | cut -d ' ' -f 1)
if [ "$HASH_NEW" != "$HASH_LAST_KNOWN" ]; then
    echo "[!] Changes to install script found..."
    echo "[!] Please review changes and update hash before proceeding..."
    exit 1
else
    echo "[*] No changes found..."
    exit 0
fi
