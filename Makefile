# PROJECT
download:
	echo "[*] Downloading the project..."
	./scripts/download.sh

verify:
	echo "[*] Verifying the project..."
	./scripts/verify.sh

customise:
	echo "[*] Updating the project..."
	./scripts/customise.sh

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
