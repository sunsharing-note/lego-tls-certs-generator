#!/bin/bash

DOCKER_REGISTRY=hub-dev.rockontrol.com
GROUP=rk-${CI_PROJECT_NAMESPACE}
PROJECT=${CI_PROJECT_NAME}
VERSION=v$(cat .version)
IMAGE=${DOCKER_REGISTRY}/${GROUP}/${PROJECT}:${VERSION}


docker buildx build --platform linux/amd64,linux/arm64 --push \
    -t ${IMAGE} \
    .
