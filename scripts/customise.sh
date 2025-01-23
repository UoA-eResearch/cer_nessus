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

# Check if the install_agent.sh script exists
if [ ! -f "$DIR_SRC/install_agent.sh" ]; then
    echo "[!] install_agent.sh script not found... Exiting."
    exit 1
fi

# Replace instance of the linking key to TENABLE_LINKING_KEY placeholder
echo "[*] Normalising install_agent.sh script..."
sed -i "s/$TENABLE_LINKING_KEY/\'\"\$LINKING_KEY\"\'/g" "$DIR_SRC/install_agent.sh"
sed -i "s/AGENT_NAME/\'\"\$AGENT_NAME\"\'/g" "$DIR_SRC/install_agent.sh"
sed -i "s/AGENT_GROUP/\'\"\$AGENT_GROUP\"\'/g" "$DIR_SRC/install_agent.sh"

# Add a line to set the custom script install tag used
echo "[*] Adding custom script install version to file..."
echo -e "CER_NESSUS_VERSION=$CER_NESSUS_VERSION" >> "/opt/nessus_agent/version"
