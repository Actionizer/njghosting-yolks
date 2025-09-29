# Node Dockerfile in Pterodactyl style

ARG NODE_VERSION
ARG NPM_VERSION

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

# Install npm & pm2 as root
ARG NPM_VERSION
RUN /bin/bash -c "NPM_VER=${NPM_VERSION:-8}; echo Installing npm \$NPM_VER; npm install -g npm@\${NPM_VER} pm2"

# Install ts-node + typescript globally so .ts files can run
RUN npm install -g ts-node typescript

# Switch to non-root for runtime
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

# Copy entrypoint
COPY ./entrypoint.sh /entrypoint.sh

# Default command
CMD ["/usr/bin/tini", "--", "/bin/bash", "/entrypoint.sh"]
