# Python Dockerfile in Pterodactyl style

# Build arg for version
ARG PYTHON_VERSION
FROM python:${PYTHON_VERSION}-bullseye

LABEL author="Jake" maintainer="jjakesv"
LABEL org.opencontainers.image.source="https://github.com/jjakesv/yolks"
LABEL org.opencontainers.image.licenses=MIT

# Install basic utilities (added iproute2 for "ip" command in entrypoint.sh)
RUN apt-get update \
    && apt-get install -y curl git build-essential ca-certificates tini iproute2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip (add Python packages here if needed)
RUN python -m pip install --upgrade pip

# Add non-root user
RUN adduser --disabled-password --gecos "" container
USER container
ENV USER=container HOME=/home/container
WORKDIR /srv/daemon-data

# Copy entrypoint (make sure it exists relative to Dockerfile)
COPY ./../entrypoint.sh /entrypoint.sh

# Default CMD
CMD [ "/bin/bash", "/entrypoint.sh" ]
