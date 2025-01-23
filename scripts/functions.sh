#!/bin/bash

DIR_PARENT=$(cd ../ && pwd)
DIR_SCRIPTS="$DIR_PARENT/scripts"
DIR_SRC="$DIR_PARENT/src"
DIR_DIST="$DIR_PARENT/dist"

URL_TENABLE_AGENT="https://sensor.cloud.tenable.com/install/agent"


check_linking_key_is_set () {
    echo "[*] Checking Tenable linking key existence..."
    # Check if TENABLE_LINKING_KEY is set in env vars
    # If not, ask user to enter it
    if [ -z "$TENABLE_LINKING_KEY" ]; then
        echo "[!] Linking key is not set..."
        read -r -p "Please enter: " TENABLE_LINKING_KEY
    fi

    # Check length of TENABLE_LINKING_KEY
    if [ ${#TENABLE_LINKING_KEY} -ne 64 ]; then
        return 1
    else
        return 0
    fi
}


check_linking_key_download () {
    echo "[*] Checking Tenable linking key download..."
    # shellcheck disable=SC1083
    status_code=$(curl \
        --silent \
        --header "X-Key: $TENABLE_LINKING_KEY" \
        --write-out %{http_code} \
        --output /dev/null \
        --get \
        "$URL_TENABLE_AGENT"
    )

    if [[ "$status_code" -ne 200 ]] ; then
        return 1
    else
        return 0
    fi
}
