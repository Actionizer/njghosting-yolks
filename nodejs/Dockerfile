# Declare build args first
ARG NODE_VERSION
ARG NPM_VERSION

FROM node:${NODE_VERSION}-bullseye

RUN apt-get update \
    && apt-get install -y curl git build-essential ca-certificates tini \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Fix: fallback npm version if ARG not substituted
RUN NPM_TO_USE=${NPM_VERSION:-8} && npm install -g npm@$NPM_TO_USE pm2

WORKDIR /srv/daemon-data