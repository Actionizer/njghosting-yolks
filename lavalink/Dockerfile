# syntax=docker/dockerfile:1
FROM --platform=$TARGETOS/$TARGETARCH eclipse-temurin:17-jdk-jammy

LABEL author="Mineturtlee"
LABEL maintainer="Mineturtlee"
LABEL org.opencontainers.image.source="https://github.com/yourusername/yolks"
LABEL org.opencontainers.image.licenses="MIT"

# Set up container user
RUN apt-get update && \
    apt-get install -y curl git tini iproute2 ca-certificates bash && \
    adduser --disabled-password --gecos "" container && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

# Copy entrypoint script
COPY ./entrypoint.sh /entrypoint.sh

# Default command
CMD ["/usr/bin/tini", "--", "/bin/bash", "/entrypoint.sh"]