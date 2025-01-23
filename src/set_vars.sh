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

# Prompt user if they want to set a different agent group
read -r -p "Do you want to set a different agent group? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
    read -r -p "Please enter the agent group: " AGENT_GROUP
fi
