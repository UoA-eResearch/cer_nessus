#!/bin/bash

cd "$(dirname "$0")" || exit 1

source functions.sh

# Check if TENABLE_LINKING_KEY is set
check_linking_key_is_set
success=$?
if [ "$success" != 0 ]; then
    echo "[!] Linking key is not set or incorrect... Exiting."
    exit 1
fi

# Check if TENABLE_LINKING_KEY is valid by testing download
check_linking_key_download
success=$?
if [ "$success" != 0 ]; then
    echo "[!] Linking key is invalid... Exiting."
    exit 1
fi

# Download the latest version of the install_agent.sh script
echo "[+] Downloading the latest version..."
# shellcheck disable=SC1083
status_code=$(curl \
    --silent \
    --header "X-Key: $TENABLE_LINKING_KEY" \
    --write-out %{http_code} \
    --output "$DIR_SRC/install_agent_new.sh" \
    --get \
    "$URL_TENABLE_AGENT" \
    -d "name=AGENT_NAME" \
    -d "groups=AGENT_GROUP"
)

if [[ "$status_code" -ne 200 ]] ; then
    echo "[!] Unable to download from Tenable... Exiting."
    exit 1
fi

# Replace instance of the linking key to TENABLE_LINKING_KEY placeholder
echo "[*] Normalising install_agent.sh script..."
sed -i "s/$TENABLE_LINKING_KEY/\'\"\$LINKING_KEY\"\'/g" "$DIR_SRC/install_agent_new.sh"
sed -i "s/AGENT_NAME/\'\"\$AGENT_NAME\"\'/g" "$DIR_SRC/install_agent_new.sh"
sed -i "s/AGENT_GROUP/\'\"\$AGENT_GROUP\"\'/g" "$DIR_SRC/install_agent_new.sh"

# Check if the new install_agent.sh script is different from the last known hash
HASH_EXISTING=$(sha256sum "$DIR_SRC/install_agent.sh" | cut -d ' ' -f 1)
HASH_NEW=$(sha256sum "$DIR_SRC/install_agent_new.sh" | cut -d ' ' -f 1)
if [ "$HASH_NEW" != "$HASH_EXISTING" ]; then
    echo "[!] Changes to install script found..."
    echo "[!] Please review changes before proceeding..."
    echo "[!] Then run:"
    echo "mv src/install_agent_new.sh src/install_agent.sh"
    exit 1
else
    echo "[*] No changes found..."
    echo "[-] Cleaning up..."
    rm "$DIR_SRC/install_agent_new.sh"
    exit 0
fi
