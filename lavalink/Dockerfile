# syntax=docker/dockerfile:1
FROM --platform=$TARGETOS/$TARGETARCH eclipse-temurin:21-jre

LABEL author="Mineturtlee"
LABEL maintainer="Mineturtlee"
LABEL org.opencontainers.image.source="https://github.com/Actionizer/NJGHosting-yolks"
LABEL org.opencontainers.image.licenses="MIT"

# Set up container user
RUN apt-get update && \
    apt-get install -y curl git tini iproute2 ca-certificates gettext-base bash && \
    adduser --disabled-password --gecos "" container && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

RUN curl -L -o /home/container/Lavalink.jar \
    https://github.com/freyacodes/Lavalink/releases/latest/download/Lavalink.jar

RUN curl -L -o /home/container/application.yml \
    https://raw.githubusercontent.com/freyacodes/Lavalink/master/LavalinkServer/application.yml.example

# Copy entrypoint script
COPY ./entrypoint.sh /entrypoint.sh

# Default command
CMD ["/usr/bin/tini", "--", "/bin/bash", "/entrypoint.sh"]
