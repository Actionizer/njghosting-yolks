#!/bin/bash
# Bun Docker Entrypoint for Pterodactyl
# Author: jjakesv870@gmail.com

set -e

# Function to print styled messages
print_msg() {
    printf "\033[1m\033[33mcontainer@njghosting \033[0m%s\n" "$1"
}

cd /home/container

# Auto-update repo if enabled
if [[ -d .git ]] && [[ "${AUTO_UPDATE}" == "1" ]]; then
    print_msg "🔄 Pulling latest changes from Git repository..."
    git pull
fi

# Install additional Bun packages
if [[ ! -z "${BUN_PACKAGES}" ]]; then
    print_msg "📦 Installing additional Bun packages..."
    bun install ${BUN_PACKAGES}
fi

# Remove Bun packages if specified
if [[ ! -z "${RMBUN_PACKAGES}" ]]; then
    print_msg "🗑️ Removing Bun packages..."
    bun remove ${RMBUN_PACKAGES}
fi

# If package.json exists, install dependencies
if [[ -f /home/container/package.json ]]; then
    print_msg "📦 Installing project dependencies from package.json..."
    bun install
fi

# Check if user uploaded files, skip if true
if [[ "${USER_UPLOAD}" == "1" || "${USER_UPLOAD}" == "true" ]]; then
    print_msg "☝️ User-uploaded files detected. Skipping installation steps."
fi

# Run the main Bun file
if [[ ! -z "${MAIN_FILE}" ]]; then
    print_msg "🚀 Starting Bun app: ${MAIN_FILE}"
    bun run ${MAIN_FILE} ${BUN_ARGS}
else
    print_msg "❌ MAIN_FILE not specified. Exiting."
    exit 1
fi
