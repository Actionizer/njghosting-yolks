# Use build arg for Python version
ARG PYTHON_VERSION
FROM python:${PYTHON_VERSION}-bullseye

# Install basic utilities
RUN apt-get update \
    && apt-get install -y curl git build-essential ca-certificates tini \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip (add Python packages here if needed)
RUN python -m pip install --upgrade pip

# Set working dir
WORKDIR /srv/daemon-data
