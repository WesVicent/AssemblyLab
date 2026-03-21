#!/bin/bash

IMAGE_NAME="asm-cmake-dev"
CONTAINER_NAME="asm-dev"

# Build image ONLY if it doesn't exist
if [[ "$(docker images -q $IMAGE_NAME 2> /dev/null)" == "" ]]; then
  echo "Building Docker image..."
  docker build \
    --build-arg USER_ID=$(id -u) \
    --build-arg GROUP_ID=$(id -g) \
    -t $IMAGE_NAME .
fi

docker run -it --rm \
  --name $CONTAINER_NAME \
  -v "$(pwd):/workspace" \
  -w /workspace \
  $IMAGE_NAME
