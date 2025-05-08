# PROJECT
download:
	echo "[*] Downloading the project..."
	./scripts/download.sh

verify:
	echo "[*] Verifying the project..."
	./scripts/verify.sh

version:
	LATEST_TAG=$(git describe --tags --abbrev=0)
	sed -i "s/^CER_NESSUS_VERSION=.*/CER_NESSUS_VERSION=${LATEST_TAG}/" scripts/functions.sh

build:
	echo "[*] Building the project..."
	./scripts/build.sh

# LINTING
lint: \
	lint_shell

lint_shell:
	find -type f -name "*.sh" \
		-not -path "./dist/*" \
		-not -path "./src/install_agent*" | \
		xargs shellcheck
