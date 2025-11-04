#!/bin/bash

# Build image if it doesn't exist
if ! docker image inspect edge-nvidia &> /dev/null; then
    echo "Building edge-nvidia image..."
    docker build -t edge-nvidia .
fi

docker run --runtime=nvidia -it --rm \
  -e NVIDIA_VISIBLE_DEVICES=all \
  edge-nvidia \
  bash
