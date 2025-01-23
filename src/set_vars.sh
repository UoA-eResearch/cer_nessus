#!/bin/bash

# set_vars.sh

# Check if LINKING_KEY is set in env vars
# If not, ask user to enter it
if [ -z "$LINKING_KEY" ]; then
    echo "[!] Linking key is not set..."
    read -r -p "Please enter: " LINKING_KEY
fi

# Check length of LINKING_KEY
if [ ${#LINKING_KEY} -ne 64 ]; then
    exit 1
fi

AGENT_NAME="nectar_$INSTANCE_UUID"
AGENT_GROUP="nectar_all"
