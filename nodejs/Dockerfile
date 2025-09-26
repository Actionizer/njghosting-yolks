# Node Dockerfile in Pterodactyl style

# Build args (must pass NODE_VERSION and optionally NPM_VERSION)
ARG NODE_VERSION
ARG NPM_VERSION

# Base image
FROM --platform=$TARGETOS/$TARGETARCH node:${NODE_VERSION}-bullseye

LABEL author="Jake" maintainer="jjakesv"
LABEL org.opencontainers.image.source="https://github.com/jjakesv/yolks"
LABEL org.opencontainers.image.licenses=MIT

# Install deps & add non-root user
RUN apt-get update \
    && apt-get install -y curl git build-essential ca-certificates tini iproute2 \
    && adduser --disabled-password --gecos "" container \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install npm & pm2 as root to avoid permission issues
ARG NPM_VERSION
RUN /bin/bash -c "NPM_VER=${NPM_VERSION:-8}; echo Installing npm \$NPM_VER; npm install -g npm@\${NPM_VER} pm2"

# Switch to non-root for runtime
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

# Copy entrypoint (make sure it exists relative to Dockerfile)
COPY ./../entrypoint.sh /entrypoint.sh

# Default command
CMD [ "/bin/bash", "/entrypoint.sh" ]