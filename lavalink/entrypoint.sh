#!/bin/bash
cd /home/container || exit 1

# Get internal IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Show Java version
echo "Java version info:"
java -version
echo ""

# Replace {{VARIABLES}} from Ptero with ${VARIABLES}
MODIFIED_STARTUP=$(echo -e "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run Lavalink
eval "${MODIFIED_STARTUP}"
