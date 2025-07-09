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

# Set agent name
AGENT_NAME="nectar_$INSTANCE_UUID"

# Check if AGENT_NAME is set in env vars
# If not, ask user to enter it
if [ -z "$AGENT_GROUP" ]; then
    echo "[!] Agent group is not set..."
    read -r -p "Please enter: " AGENT_GROUP
fi

# Check agent group starts with nectar_
if [[ ! "$AGENT_GROUP" =~ ^nectar_ ]]; then
    echo "[!] Agent group must start with 'nectar_'"
    exit 1
fi
