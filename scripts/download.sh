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
    --output "$DIR_SRC/install_agent.sh" \
    --get \
    "$URL_TENABLE_AGENT" \
    -d "name=AGENT_NAME" \
    -d "groups=AGENT_GROUP"
)

if [[ "$status_code" -ne 200 ]] ; then
    echo "[!] Unable to download from Tenable... Exiting."
    exit 1
fi
