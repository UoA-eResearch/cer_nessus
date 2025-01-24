#!/bin/bash

cd "$(dirname "$0")" || exit 1

source functions.sh

# Create dist folder if it doesn't exist
if [ ! -d "$DIR_DIST" ]; then
    echo "[+] Creating dist folder..."
    mkdir "$DIR_DIST"
fi

TARGET_INSTALLER_SCRIPT="$DIR_DIST/install.sh"

# If installer script exists, remove it
if [ -f "$TARGET_INSTALLER_SCRIPT" ]; then
    echo "[-] Removing existing installer script..."
    rm -f "$TARGET_INSTALLER_SCRIPT"
fi

# Set shebang
echo -e "#!/bin/bash\n" >> "$TARGET_INSTALLER_SCRIPT"

# get_instance_uuid.sh
echo "[+] Adding get_instance_uuid.sh to installer script..."
tail -n +2 "$DIR_SRC/get_instance_uuid.sh" >> "$TARGET_INSTALLER_SCRIPT"

# set_vars.sh
echo "[+] Adding set_vars.sh to installer script..."
tail -n +2 "$DIR_SRC/set_vars.sh" >> "$TARGET_INSTALLER_SCRIPT"

# install_agent.sh
if [ ! -f "$DIR_SRC/install_agent.sh" ]; then
    echo "[!] Script install_agent.sh not found..."
    echo "[!] Please run update.sh to download the latest version..."
    echo "[!] Exiting."
    exit 1
fi
echo "[+] Adding install_agent.sh to installer script..."
echo -e "\n# install_agent.sh\n" >> "$TARGET_INSTALLER_SCRIPT"
tail -n +2 "$DIR_SRC/install_agent.sh" >> "$TARGET_INSTALLER_SCRIPT"

# Append a line to the installer script to set the version
echo "[+] Adding custom script install version to file..."
echo -e "\necho 'CER_NESSUS_VERSION=$CER_NESSUS_VERSION'  | sudo tee /opt/nessus_agent/version" >> "$TARGET_INSTALLER_SCRIPT"
