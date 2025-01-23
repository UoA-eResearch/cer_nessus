# PROJECT
update:
	echo "[*] Updating the project..."
	./scripts/update.sh

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
