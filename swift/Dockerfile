# syntax=docker/dockerfile:1

ARG VERSION

FROM swift:${VERSION}-focal

LABEL author="Jake"
LABEL maintainer="jjakesv"
LABEL org.opencontainers.image.source="https://github.com/jjakesv/yolks"
LABEL org.opencontainers.image.licenses="MIT"

# Set up container user
adduser --disabled-password --gecos "" container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

# Copy entrypoint script
COPY ./entrypoint.sh /entrypoint.sh

# Default command
CMD ["/usr/bin/tini", "--", "/bin/bash", "/entrypoint.sh"]
