# Python Dockerfile in Pterodactyl style

# Build arg for version
ARG PYTHON_VERSION
FROM --platform=$TARGETOS/$TARGETARCH python:${PYTHON_VERSION}-bullseye

LABEL author="Jake" maintainer="jjakesv"
LABEL org.opencontainers.image.source="https://github.com/jjakesv/yolks"
LABEL org.opencontainers.image.licenses=MIT

# Install deps & add non-root user
RUN apt-get update \
    && apt-get install -y curl git build-essential ca-certificates tini iproute2 \
    && adduser --disabled-password --gecos "" container \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip & install common Python packages (add more if needed)
RUN python -m pip install --upgrade pip

# Switch to non-root user
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

# Copy entrypoint
COPY ./../entrypoint.sh /entrypoint.sh

# Default CMD using tini
CMD ["/usr/bin/tini", "--", "/bin/ash", "/entrypoint.sh"]
