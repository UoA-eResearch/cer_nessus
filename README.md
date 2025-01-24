# cer_nessus

Easy Tenable Nessus agent installer for CeR

## Automated

```
export LINKING_KEY=<PASTE_LINKING_KEY_HERE>
curl -o- https://uoa-eresearch.github.io/cer_nessus/install.sh | bash
unset LINKING_KEY
```

## Manual

- More secure, as you can review script contents before execution
- User prompted for `LINKING_KEY` when run
- Option to change the `AGENT_GROUP` (comma-separated list without spaces)

```
curl -sf -L https://uoa-eresearch.github.io/cer_nessus/install.sh -o install.sh
less install.sh
chmod u+x install.sh
bash install.sh
```

## Uninstall

### Ubuntu

```
sudo apt remove -y --purge nessusagent
sudo rm -rf /opt/nessus_agent
```
