# cer_nessus

Easier Tenable Nessus agent installer for CeR

## Quickstart

```
curl -o install.sh https://uoa-eresearch.github.io/cer_nessus/install.sh
chmod u+x install.sh
sudo ./install.sh
```

You will be prompted for:

- Tenable linking key (from Secret Server `eResearch > Nectar > Tenable linking key`)

## Uninstalling Nessus

```
sudo apt remove -y --purge nessusagent
sudo rm -rf /opt/nessus_agent
```

## Updating Project

Get the Tenable Linking key.

Update the local Tenable Nessus installer script (`./src/install_agent.sh`):

```
./scripts/download.sh 
[*] Checking Tenable linking key existence...
[!] Linking key is not set...
Please enter: <REDACTED>
[*] Checking Tenable linking key download...
[+] Downloading the latest version...
[*] Download successful...
[*] Normalising install_agent.sh script...
[*] a9ca24ba3a5cc4e2add4ebd856e504b4e60491aa83cb0409007bd20f539b2762  install_agent.sh
```

Verify the script to see if changes have occurred:

```
./scripts/verify.sh
```

If you get the following output, the script has changed:

```
[!] Changes to install script found...
[!] Please review changes and update hash before proceeding...
```

Review the installer script manually, and/or check `git diff`

```
git diff src/install_agent.sh
```

Copy the updated hash to `src/functions.sh` and re-verify:

```
./scripts/verify.sh
```

Once happy, build the custom script:

```
./scripts/build.sh 
[+] Adding get_instance_uuid.sh to installer script...
[+] Adding set_vars.sh to installer script...
[+] Adding install_agent.sh to installer script...
[+] Adding custom script install version to file...
```

If this process passes you can proceed:

- Push to GitHub
- Tag and release new version
- This will rebuild and deploy
