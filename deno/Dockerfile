FROM --platform=$TARGETOS/$TARGETARCH deno:debian

LABEL author="Jake" maintainer="jjakesv"
LABEL org.opencontainers.image.source="https://github.com/jjakesv/yolks"
LABEL org.opencontainers.image.licenses=MIT

# Install deps & add non-root user
RUN apt-get update \
    && apt-get install -y curl git build-essential ca-certificates tini iproute2 \
    && adduser --disabled-password --gecos "" container \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Switch to non-root for runtime
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

# Copy entrypoint
COPY ./entrypoint.sh /entrypoint.sh

# Default command
CMD ["/usr/bin/tini", "--", "/bin/bash", "/entrypoint.sh"]
