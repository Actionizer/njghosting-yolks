#!/bin/bash
cd /home/container

# Make internal IP available
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Show Java version
java -version

# Replace {{VAR}} → ${VAR} in Pterodactyl startup
MODIFIED_STARTUP="java -jar Lavalink.jar"

# Show final startup command
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run Lavalink
eval "${MODIFIED_STARTUP}"
